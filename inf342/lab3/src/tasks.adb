with IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Dynamic_Priorities;  use Ada.Dynamic_Priorities;

package body Tasks is

   N_Tasks     : Natural := 0;
   --  Number of tasks in the scenario

   N_Loop_1 : constant Natural   := 1_000;
   N_Loop_2 : constant Natural   := 200_000;
   F_Base   : constant Float     := 1.0001;

   --  Q or Quantum
   Q    : constant Time_Span := Milliseconds (10);
   M    : constant Time_Span := Milliseconds (1);

   protected Monocore is
      entry Acquire;
      entry Release_And_Acquire;
      procedure Release;
   private
      Busy : Boolean := False;
   end Monocore;

   --------------
   -- Monocore --
   --------------

   protected body Monocore is
      entry Acquire when not Busy is
      begin
         Busy := True;
      end Acquire;

      entry Release_And_Acquire when True is
      begin
         Busy := False;
         requeue Acquire;
      end Release_And_Acquire;

      procedure Release is
      begin
         Busy := False;
      end Release;
   end Monocore;

   ------------------------------
   -- Compute_During_Time_Span --
   ------------------------------

   procedure Compute_During_Time_Span (N : Task_Name; T : Time_Span) is
      W : Time_Span := T;
      C : Time;

   begin
      Monocore.Acquire;
      while Q < W loop
         C := Clock + Q;
         while Clock < C loop
            null;
         end loop;
         W := W - Q;
         Monocore.Release_And_Acquire;
      end loop;
      Monocore.Release;
   end Compute_During_Time_Span;

   ---------------------
   -- Next_Activation --
   ---------------------

   function Next_Activation (P : Time_Span) return Time
   is
      N1, N2, N3 : Natural;

   begin
      N1 := (Clock - Activation_Time) / M;
      N2 := P / M;
      N3 := N1 / N2 + 1;
      return Activation_Time + N3 * P;
   end Next_Activation;

   --------------
   -- Put_Task --
   --------------

   procedure Put_Task (T : Task_Info) is
   begin
      IO.Put_Header (T.Name);
      IO.Put_String ("C=");
      IO.Put_Time_Span (T.Computation);
      if T.Kind = K_Aperiodic_Task then
         IO.Put_String    (" A=");
         IO.Put_Time_Span (T.Activation);
      else
         IO.Put_String    (" D=");
         IO.Put_Time_Span (T.Period);
      end if;
      IO.New_Line;
   end Put_Task;

   ---------------
   -- Semaphore --
   ---------------

   protected body Semaphore is

      -------------
      -- Acquire --
      -------------

      entry Acquire when Not_Empty is
      begin
         N := N - 1;
         Not_Empty := (N > 0);
      end Acquire;

      -------------
      -- Release --
      -------------

      procedure Release is
      begin
         N := N + 1;
         Not_Empty := (N > 0);
      end Release;

   end Semaphore;

   -----------------------
   -- Signal_Activation --
   -----------------------

   procedure Signal_Activation is
   begin
      Activation_Done   := True;
      Activation_Time   := Clock + Seconds (1);
      Finalization_Time := Activation_Time + Execution_Time;
   end Signal_Activation;

   ---------------------
   -- Time_Left_Until --
   ---------------------

   function Time_Left_Until (T : Time) return Time_Span is
   begin
      return Q * ((T - Clock) / Q);
   end Time_Left_Until;

end Tasks;


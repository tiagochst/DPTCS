with Ada.Real_Time;          use Ada.Real_Time;
with Ada.Exceptions;         use Ada.Exceptions;
with GNAT.Heap_Sort_A;       use GNAT.Heap_Sort_A;
with IO;                     use IO;
with System;                 use System;
with Scenarii;               use Scenarii;
with Tasks;                  use Tasks;

package body Periodic_Tasks is

   task type Runnable_Task (N : Natural) is
      pragma Priority (Default_Priority + N);
   end Runnable_Task;
   type Runnable_Task_Ptr is access all Runnable_Task;

   Runnable_Lock_T1 : aliased Semaphore (0);
   Runnable_Lock_T2 : aliased Semaphore (0);
   Runnable_Lock_T3 : aliased Semaphore (0);
   Runnable_Lock_T4 : aliased Semaphore (0);

   Runnable_Task_T1 : aliased Runnable_Task (1);
   Runnable_Task_T2 : aliased Runnable_Task (2);
   Runnable_Task_T3 : aliased Runnable_Task (3);
   Runnable_Task_T4 : aliased Runnable_Task (4);

   type Runnable_Task_Type is record
      Runnable_Lock : Semaphore_Ptr;
      Runnable_Task : Runnable_Task_Ptr;
   end record;

   Runnable_Task_Table : constant array (0 .. 4) of Runnable_Task_Type :=
     ((null, null),
      (Runnable_Lock_T1'Access, Runnable_Task_T1'Access),
      (Runnable_Lock_T2'Access, Runnable_Task_T2'Access),
      (Runnable_Lock_T3'Access, Runnable_Task_T3'Access),
      (Runnable_Lock_T4'Access, Runnable_Task_T4'Access));

   Main_Table : array (Task_Kind) of Main_Type := (others => null);

   function  Less (L, R : Natural) return Boolean;
   procedure Move (L, R : Natural);
   procedure Sort_Table;

   --------------
   -- Activate --
   --------------

   procedure Activate is
   begin
      delay until Activation_Time;
      for I in reverse Runnable_Task_Table'Range loop
         if Runnable_Task_Table (I).Runnable_Lock /= null then
            Runnable_Task_Table (I).Runnable_Lock.Release;
         end if;
      end loop;
   end Activate;

   ---------
   -- Add --
   ---------

   procedure Add (Kind : Task_Kind; Main : Main_Type) is
   begin
      if Main_Table (Kind) /= null then
         raise Program_Error;
      end if;
      Main_Table (Kind) := Main;
   end Add;

   --------------
   -- Finalize --
   --------------

   procedure Finalize is
   begin
      delay until Finalization_Time + Seconds (1);
      for I in Runnable_Task_Table'Range loop
         if Runnable_Task_Table (I).Runnable_Lock /= null then
            Runnable_Task_Table (I).Runnable_Lock.Release;
         end if;
      end loop;
   end Finalize;

   ----------
   -- Less --
   ----------

   function Less (L, R : Natural) return Boolean is
   begin
      --NYI ("== FUNCION LESS PERIODIC-TASK.adb ===");
      --NYI ("which task has the greatest priority?");

      if Periodic_Task_Table(L).Period > Periodic_Task_Table(R).Period
      then
	 return True;
      end if;
      return False;
   end Less;

   ----------
   -- Move --
   ----------

   procedure Move (L, R : Natural) is
   begin
      Periodic_Task_Table (R) := Periodic_Task_Table (L);
   end Move;

   -------------------
   -- Runnable_Task --
   -------------------

   task body Runnable_Task is
      Info : Task_Info;

   begin
      Runnable_Task_Table (N).Runnable_Lock.Acquire;
      Info := Periodic_Task_Table (N);

      if Info /= Null_Task then
         Put_Header  (Info.Name);
         Put_String  ("P=");
         Put_Natural (N);
         New_Line;

         Main_Table (Info.Kind) (Info);

         Runnable_Task_Table (N).Runnable_Lock.Acquire;
         Put_Header (Info.Name);
         Put_String ("finalized");
         New_Line;
      end if;

   exception when E : others =>
      Put_Header ("Periodic Task");
      Put_String ("exception ");
      Put_String (Exception_Name (E));
      New_Line;
      Put_Header ("Periodic Task");
      Put_String (Exception_Message (E));
      New_Line;
   end Runnable_Task;

   -------------------
   -- Set_Scheduler --
   -------------------

   procedure Set_Scheduler (S : Scheduling_Policy) is
   begin
      --  Check whether we sort the task table and assign priorities
      --  to them. This should occur when RMS periodic tasks have been
      --  created.

      if S = RMS_Scheduling then
         Put_Header ("Compute Priorities");
         New_Line;
         Sort_Table;
      end if;

      --  Print the periodic task list

      for I in First_Periodic_Task .. Last_Periodic_Task loop
         Put_Task (Periodic_Task_Table (I));
      end loop;
   end Set_Scheduler;

   ----------------
   -- Sort_Table --
   ----------------

   procedure Sort_Table is
   begin
      Sort (Natural (Last_Periodic_Task), Move'Access, Less'Access);
   end Sort_Table;


   ------------------------
   -- Periodic_Task_Main --
   ------------------------

   procedure Periodic_Task_Main (Info : Task_Info) is
      Deadline : Time := Activation_Time;

   begin
      loop
         Put_Header    (Info.Name);
         Put_String    ("activated");
         New_Line;

         exit when Clock > Finalization_Time;
         Compute_During_Time_Span (Info.Name, Info.Computation);

         Put_Header    (Info.Name);
         Put_String    ("completed");
         New_Line;
	 
	 --NYI ("recompute the next deadline");
         Deadline := Deadline + Info.Period;

         exit when Deadline > Finalization_Time;

         --  Check the completion time is not over

         if Deadline < Clock then
            Put_Header    (Info.Name);
            Put_String    ("OVERRUN ");
            New_Line;
         end if;

         --  Suspend until end of period
         --NYI ("wait for the next activation");
	 delay until Deadline; 
      end loop;
   end Periodic_Task_Main;

begin
   Add (K_Periodic_Task, Periodic_Task_Main'Access);
end Periodic_Tasks;

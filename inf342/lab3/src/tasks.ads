with Ada.Real_Time;          use Ada.Real_Time;
with System;                 use System;

package Tasks is

   type Scheduling_Policy is
     (FIFO_Scheduling,
      RMS_Scheduling);

   type Task_Kind is
     (K_No_Task,
      K_Periodic_Task,
      K_Aperiodic_Task,
      K_Background_Server,
      K_Polling_Server,
      K_Deferred_Server,
      K_Sporadic_Server);

   subtype Task_Name is String (1 .. 2);
   --  A task name includes a prefix and its id on two digits. The
   --  prefix is :
   --  "pX" for periodic task
   --  "aX" for aperiodic task
   --  "bs" for background server
   --  "ps" for polling server
   --  "ds" for deferred server
   --  "ss" for sporadic server

   type Task_Info is record
      Scenario    : Natural  := 0;
      Kind        : Task_Kind;
      Name        : Task_Name;
      Computation : Time_Span;
      Activation  : Time_Span;
      Period      : Time_Span;
   end record;
   --  For aperiodic task, attribute Activation is valid and attribute
   --  Period is not. Otherwise, attribute Period is valid and attribute
   --  Activation is not.

   Null_Task : constant Task_Info
     := (Scenario     => 0,
         Kind         => K_No_Task,
         Name         => (others => ' '),
         Activation   => Milliseconds (0),
         Period       => Milliseconds (0),
         Computation  => Milliseconds (0));

   procedure Put_Task (T : in  Task_Info);
   --  Print task info on the current output.

   function Next_Activation (P : Time_Span) return Time;
   function Time_Left_Until (T : Time) return Time_Span;

   procedure Signal_Activation;

   Activation_Done   : Boolean := False;
   Activation_Time   : Time := Clock;
   Finalization_Time : Time := Clock;
   Execution_Time    : Time_Span := Seconds (60);

   procedure Compute_During_Time_Span (N : Task_Name; T : Time_Span);
   --  Effectuer des calculs pendant un laps de temps T

   protected type Semaphore (Initial : Integer) is
      entry Acquire;
      procedure Release;
   private
      N         : Integer := Initial;
      Not_Empty : Boolean := (Initial > 0);
   end Semaphore;
   type Semaphore_Ptr is access all Semaphore;

end Tasks;


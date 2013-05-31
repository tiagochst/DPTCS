with Tasks;         use Tasks;

package Aperiodic_Tasks is

   Task_Table : array (0 .. 31) of Task_Info;
   First_Task : constant Natural := 1;
   Last_Task  : Natural := 0;

   procedure Create (I : Task_Info);
   --  Append an aperiodic task to the aperiodic task list

   procedure Destroy;

end Aperiodic_Tasks;

with Tasks;  use Tasks;

package Periodic_Tasks is

   type Main_Type is access procedure (Info : Task_Info);

   procedure Set_Scheduler (S : Scheduling_Policy);
   procedure Activate;
   procedure Finalize;

   procedure Add (Kind : Task_Kind; Main : Main_Type);

end Periodic_Tasks;

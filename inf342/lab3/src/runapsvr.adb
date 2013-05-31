with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Exceptions;      use Ada.Exceptions;
with Aperiodic_Servers;   use Aperiodic_Servers;
with Aperiodic_Tasks;     use Aperiodic_Tasks;
with IO;                  use IO;
with Periodic_Tasks;      use Periodic_Tasks;
with Scenarii;            use Scenarii;
with Tasks;               use Tasks;

procedure RunAPSvr is
   Info     : Task_Info;
   Scenario : Natural;

begin
   Scenario := Natural'Value (Argument (1));
   Load_Scenario (Scenario);

   for T in Scenario_Table'Range loop
      Info := Scenario_Table (T);
      if Info.Scenario = Scenario then
         case Info.Kind is
            when K_No_Task =>
               exit;
            when K_Periodic_Task =>
               null;
            when K_Aperiodic_Task =>
               Aperiodic_Tasks.Create (Info);
            when others =>
               Aperiodic_Servers.Create (Info);
         end case;
      end if;
   end loop;

   Periodic_Tasks.Set_Scheduler (RMS_Scheduling);
   Tasks.Signal_Activation;

   Aperiodic_Servers.Activate;
   Periodic_Tasks.Activate;

   Aperiodic_Servers.Finalize;
   Periodic_Tasks.Finalize;

exception when E : others =>
   Put_Header ("Main Task");
   Put_String ("exception ");
   Put_String (Exception_Name (E));
   New_Line;
   Put_Header ("Main Task");
   Put_String (Exception_Message (E));
   New_Line;
end RunAPSvr;

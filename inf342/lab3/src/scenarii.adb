package body Scenarii is

   -------------------
   -- Load_Scenario --
   -------------------

   procedure Load_Scenario (S : Natural) is
   begin
      First_Periodic_Task  := 1;
      Last_Periodic_Task   := 0;
      First_Aperiodic_Task := 1;
      Last_Aperiodic_Task  := 0;

      for T in Scenario_Table'Range loop
         if Scenario_Table (T).Scenario = S then
            if Scenario_Table (T).Kind = K_Aperiodic_Task then
               Last_Aperiodic_Task := Last_Aperiodic_Task + 1;
               Aperiodic_Task_Table (Last_Aperiodic_Task)
                 := Scenario_Table (T);

            else
               Last_Periodic_Task := Last_Periodic_Task + 1;
               Periodic_Task_Table (Last_Periodic_Task)
                 := Scenario_Table (T);
            end if;
         end if;
      end loop;
   end Load_Scenario;

end Scenarii;

with Tasks;         use Tasks;
with Ada.Real_Time; use Ada.Real_Time;

package Scenarii is

   type Task_Table is array (Natural range <>) of Task_Info;

   Scenario_Table : constant Task_Table :=
     -- Scenario, Kind, Name, Capacity, Activation, Period
     ((1, K_Periodic_Task, "p1",     Seconds (4), Seconds (00), Seconds (10)),
      (1, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (15)),

      (2, K_Periodic_Task, "p1",     Seconds (4), Seconds (00), Seconds (10)),
      (2, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (15)),
      (2, K_Periodic_Task, "p3",     Seconds (6), Seconds (00), Seconds (18)),

      (3, K_Periodic_Task, "p1",     Seconds (2), Seconds (00), Seconds (05)),
      (3, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (15)),
      (3, K_Periodic_Task, "p3",     Seconds (1), Seconds (00), Seconds (03)),

      (4, K_Periodic_Task, "p1",     Seconds (6), Seconds (00), Seconds (20)),
      (4, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (10)),
      (4, K_Background_Server, "bs", Seconds (0), Seconds (00), Seconds (99)),
      (4, K_Aperiodic_Task, "a1",    Seconds (3), Seconds (07), Seconds (00)),
      (4, K_Aperiodic_Task, "a2",    Seconds (4), Seconds (11), Seconds (00)),

      (5, K_Periodic_Task, "p1",     Seconds (6), Seconds (00), Seconds (20)),
      (5, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (10)),
      (5, K_Polling_Server, "ps",    Seconds (2), Seconds (00), Seconds (08)),
      (5, K_Aperiodic_Task, "a1",    Seconds (3), Seconds (07), Seconds (00)),
      (5, K_Aperiodic_Task, "a2",    Seconds (4), Seconds (11), Seconds (00)),

      (6, K_Periodic_Task, "p1",     Seconds (6), Seconds (00), Seconds (20)),
      (6, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (10)),
      (6, K_Deferred_Server, "ds",   Seconds (2), Seconds (00), Seconds (08)),
      (6, K_Aperiodic_Task, "a1",    Seconds (3), Seconds (07), Seconds (00)),
      (6, K_Aperiodic_Task, "a2",    Seconds (4), Seconds (11), Seconds (00)),

      (7, K_Periodic_Task, "p1",     Seconds (6), Seconds (00), Seconds (20)),
      (7, K_Periodic_Task, "p2",     Seconds (4), Seconds (00), Seconds (10)),
      (7, K_Sporadic_Server, "ss",   Seconds (2), Seconds (00), Seconds (08)),
      (7, K_Aperiodic_Task, "a1",    Seconds (3), Seconds (07), Seconds (00)),
      (7, K_Aperiodic_Task, "a2",    Seconds (4), Seconds (11), Seconds (00)),

      (0, K_No_Task, "  ",           Seconds (0), Seconds (00), Seconds (00))
     );

   Periodic_Task_Table : Task_Table (0 .. 8) := (others => Null_Task);
   First_Periodic_Task : Natural := 1;
   Last_Periodic_Task  : Natural := 0;

   Aperiodic_Task_Table : Task_Table (0 .. 8) := (others => Null_Task);
   First_Aperiodic_Task : Natural := 1;
   Last_Aperiodic_Task  : Natural := 0;

   procedure Load_Scenario (S : Natural);

end Scenarii;


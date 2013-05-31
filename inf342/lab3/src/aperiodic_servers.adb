with Background_Servers; use Background_Servers;
with Deferred_Servers;   use Deferred_Servers;
with Polling_Servers;    use Polling_Servers;
with Sporadic_Servers;   use Sporadic_Servers;
with Tasks;              use Tasks;
with Events;             use Events;
with Periodic_Tasks;     use Periodic_Tasks;

package body Aperiodic_Servers is

   Server : Task_Info := Null_Task;

   ------------
   -- Create --
   ------------

   procedure Create (T : Task_Info) is
   begin
      --  There should be only one aperiodic server per run.

      if Server /= Null_Task then
         raise Constraint_Error;
      end if;
      Server := T;
   end Create;

   --------------
   -- Activate --
   --------------

   procedure Activate is
   begin
      Produce_Event_Table;
      Add (K_Background_Server, Background_Servers.Main'Access);
      Add (K_Sporadic_Server,   Sporadic_Servers.Main'Access);
      Add (K_Deferred_Server,   Deferred_Servers.Main'Access);
      Add (K_Polling_Server,    Polling_Servers.Main'Access);
   end Activate;

   --------------
   -- Finalize --
   --------------

   procedure Finalize is
   begin
      null;
   end Finalize;

end Aperiodic_Servers;

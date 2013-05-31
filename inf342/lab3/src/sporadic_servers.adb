With Ada.Exceptions;         use Ada.Exceptions;
with Ada.Real_Time;          use Ada.Real_Time;
with Events;                 use Events;
with IO;                     use IO;
with System;                 use System;
with Tasks;                  use Tasks;
with Periodic_Tasks;

package body Sporadic_Servers is

   ----------
   -- Main --
   ----------

   procedure Main (Info : Task_Info) is
      E : Event;
      C : Time_Span;
      S : Task_Info := Info;

   begin
      while Last_Event > 0
        and then Finalization_Time > Clock
      loop

         --  Before handling the next event check the server capacity
         --  is not empty

         if S.Computation = Time_Span_Zero then

            --  Look for the first Produce event

            for I in First_Event .. Last_Event loop
               E := Event_Table (I);
               if E.Kind = K_Produce then

                  exit when E.Activation > Finalization_Time;

                  --  Remove Produce event and then wait for its
                  --  activation time

                  NYI ("remove event and wait for its activation time");

                  Put_Header    (S.Name);
                  Put_String    ("C=");
                  Put_Time_Span (S.Computation);
                  Put_String    ("+");
                  Put_Time_Span (E.Computation);
                  New_Line;

                  --  Update the server capacity and schedule the next
                  --  Produce event. To do so compute the next
                  --  activation time and the computation time
                  --  delivered to replenish.

                  NYI ("update server capacity");
                  exit;
               end if;
            end loop;
         end if;

         --  At this point the server capacity is not empty

         E := Event_Table (First_Event);
         exit when E.Activation > Finalization_Time;

         NYI ("wait for event activation");

         if E.Kind = K_Produce then

            --  Remove Produce event and handle it

               NYI ("remove event and handle it");

               Put_Header    (S.Name);
               Put_String    ("C=");
               Put_Time_Span (S.Computation);
               Put_String    ("+");
               Put_Time_Span (E.Computation);
               New_Line;

         elsif E.Kind = K_Consume then

            --  Evaluate the computation time given to the server and
            --  update its remaining capacity

            NYI ("evaluate computation time for event");

            Put_Header    (S.Name);
            Put_String    ("C=");
            Put_Time_Span (S.Computation);
            Put_String    ("-");
            Put_Time_Span (C);
            Put_String    (" ");
            Put_String    (E.Name);
            Put_String    ("=");
            Put_Time_Span (E.Computation);
            New_Line;

            S.Computation := S.Computation - C;

            --  Update the computation time of event E and remove
            --  first event or update depending on whether it is
            --  completed or not.

            E.Computation := E.Computation - C;
            Event_Table (First_Event) := E;

            NYI ("remove event when completed");

            --  Schedule the next replenishment using the current event

            NYI ("replenish the consumed computation time");

            Put_Header    (S.Name);
            Put_String    ("C+");
            Put_Time_Span (E.Computation);
            Put_String    (" @");
            Put_Time_Span (E.Activation - Activation_Time);
            New_Line;

            Compute_During_Time_Span (S.Name, C);
         end if;
      end loop;
      delay until Finalization_Time;
   end Main;

end Sporadic_Servers;

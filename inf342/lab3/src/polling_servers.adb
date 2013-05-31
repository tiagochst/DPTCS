with Ada.Exceptions;         use Ada.Exceptions;
with Ada.Real_Time;          use Ada.Real_Time;
with Events;                 use Events;
with IO;                     use IO;
with Periodic_Tasks;         use Periodic_Tasks;
with System;                 use System;
with Tasks;                  use Tasks;

package body Polling_Servers is

   ----------
   -- Main --
   ----------

   procedure Main (Info : Task_Info) is
      E : Event;
      C : Time_Span;
      S : Task_Info := Info;

   begin
      --  First schedule an event to renew the server capacity
      E.Kind        := K_Produce;
      E.Name        := S.Name;
      E.Activation  := Next_Activation (S.Period);
      E.Computation := S.Computation;
      S.Computation := Time_Span_Zero;
      Append_Event (E);

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
                  Put_Time_Span (E.Computation);
                  New_Line;

                  --  Update the server capacity and schedule the next
                  --  Produce event. To do so compute the next
                  --  activation time and the computation time
                  --  delivered to replenish.

                  NYI ("update server capacity and schedule replenishment");

                  Put_Header    (S.Name);
                  Put_String    ("C=");
                  Put_Time_Span (E.Computation);
                  Put_String    (" @");
                  Put_Time_Span (E.Activation - Activation_Time);
                  New_Line;
                  exit;
               end if;
            end loop;
         end if;

         --  At this point the server capacity is not empty

         E := Event_Table (First_Event);
         exit when E.Activation > Finalization_Time;

         if E.Kind = K_Produce then

            --  Remove Produce event and then wait for its
            --  activation time

            NYI ("remove event and wait for its activation time");

            --  As there are no Consume events to handle, the server
            --  discards its current capacity. Schedule its replenishment.
            --  Time_Span_Zero represents a zero capacity

            NYI (" and schedule replenishment");

            Put_Header    (S.Name);
            Put_String    ("C=");
            Put_Time_Span (E.Computation);
            Put_String    (" @");
            Put_Time_Span (E.Activation - Activation_Time);
            New_Line;

         elsif E.Activation > Clock then

            --  There is no current Consume event to handle. The
            --  server discards its capacity.

            S.Computation := Time_Span_Zero;

         else

            --  Evaluate the computation time needed to handle this
            --  event that is the computation time requested and the
            --  one available on the server.

            NYI ("evaluate computation time for event");

            --  Remove the event once it is completed or update the
            --  computation time needed to complete it.

            NYI ("remove event when completed");

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

            --  Update the server capacity

            NYI ("update the server capacity");

            Compute_During_Time_Span (S.Name, C);
         end if;
      end loop;
   end Main;

end Polling_Servers;

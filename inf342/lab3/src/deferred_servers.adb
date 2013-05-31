with Ada.Exceptions;         use Ada.Exceptions;
with Ada.Real_Time;          use Ada.Real_Time;
with Events;                 use Events;
with IO;                     use IO;
with Periodic_Tasks;         use Periodic_Tasks;
with System;                 use System;
with Tasks;                  use Tasks;

package body Deferred_Servers is

   HMS : constant Time_Span := Milliseconds (100);

   ----------
   -- Main --
   ----------

   procedure Main (Info : Task_Info) is
      E : Event;
      C : Time_Span;
      L : Time_Span;
      S : Task_Info := Info;
      T : Time;

   begin
      --  First schedule an event to renew the server capacity
      E.Kind        := K_Produce;
      E.Name        := S.Name;
      E.Activation  := Activation_Time;
      E.Computation := S.Computation;
      Append_Event (E);
      S.Computation := Time_Span_Zero;
      T  := Activation_Time;

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

            S.Computation := E.Computation;

            --  Schedule the next replenishment

            NYI ("schedule replenishment");

            Put_Header    (S.Name);
            Put_String    ("C=");
            Put_Time_Span (E.Computation);
            Put_String    (" @");
            Put_Time_Span (E.Activation - Activation_Time);
            New_Line;

         else

            --  Wait for the event activation time

            delay until E.Activation;


            --  Evaluate the computation time needed to handle this
            --  event that is the computation time requested and the
            --  one available on the server.

            NYI ("evaluate computation time for event");

            --  The computation must not extend over the next
            --  replenishment. As a consequence, the final computation
            --  time must not last after the next replenishment. Use
            --  Time_Left_Until function in that purpose.

            NYI ("evaluate computation time to not extend over replenishment");

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

            --  Update the computation time of event E and remove
            --  first event or update depending on whether it is
            --  completed or not.

            E.Computation := E.Computation - C;
            Event_Table (First_Event) := E;

            NYI ("remove event when completed");

            --  If the computation time is modified not to extend over
            --  the replenishment, then set server capacity to zero
            --  (Time_Span_Zero). This forces the server to take into
            --  account the replenishment event in first place even if
            --  the current Consume event is first in event
            --  table. Otherwise, if the computation time does not
            --  extend over the next replenishment, update the server
            --  capacity accordingly.

            NYI ("discard capacity when replenishment occurs during computation");

            Compute_During_Time_Span (S.Name, C);
         end if;
      end loop;
   end Main;

end Deferred_Servers;

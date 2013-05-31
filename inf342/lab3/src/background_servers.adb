with Ada.Exceptions;         use Ada.Exceptions;
with Ada.Real_Time;          use Ada.Real_Time;
with Events;                 use Events;
with IO;                     use IO;
with System;                 use System;
with Tasks;                  use Tasks;
with Periodic_Tasks;         use Periodic_Tasks;

package body Background_Servers is

   ----------
   -- Main --
   ----------

   procedure Main (Info : Task_Info) is
      E : Event;
      S : Task_Info := Info;

   begin
      while Last_Event > 0
        and then Finalization_Time > Clock
      loop
         E := Event_Table (First_Event);

         NYI ("wait for event activation");

         Put_Header    (S.Name);
         Put_String    ("C=oo ");
         Put_String    (E.Name);
         Put_String    ("=");
         Put_Time_Span (E.Computation);
         New_Line;

         NYI ("remove and handle event");

         Put_Header    (S.Name);
         Put_String    ("C=oo ");
         Put_String    (E.Name);
         Put_String    ("=0");
         New_Line;
      end loop;
      delay until Finalization_Time;
   end Main;

end Background_Servers;

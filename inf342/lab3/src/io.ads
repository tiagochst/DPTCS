with Ada.Real_Time; use Ada.Real_Time;

package IO is

   procedure Get
     (From : String;
      Item : out Time_Span;
      Last : out Positive);
   procedure Get
     (Item : out Time_Span);

   procedure Put_Header    (Item : in String);
   procedure Put_Time_Span (Item : in Time_Span);
   procedure Put_String    (Item : in String);
   procedure Put_Natural   (Item : in Natural);

   procedure New_Line;

   procedure NYI (Message : String);
   --  Raise exception Not_Yet_Implemented with message. This means that
   --  you forgot to implement somehting important.

end IO;

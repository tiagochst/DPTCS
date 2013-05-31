with Ada.Exceptions;      use Ada.Exceptions;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Tasks;               use Tasks;

package body IO is

   One_Second : constant Time_Span := Seconds (1);
   One_Millis : constant Time_Span := Milliseconds (1);

   Not_Yet_Implemented : exception;

   protected Lock is
      entry Acquire;
      procedure Release;
   private
      N         : Integer := 1;
      Not_Empty : Boolean := True;
   end Lock;

   ----------
   -- Lock --
   ----------

   protected body Lock is

      -------------
      -- Acquire --
      -------------

      entry Acquire when Not_Empty is
      begin
         N := N - 1;
         Not_Empty := (N > 0);
      end Acquire;

      -------------
      -- Release --
      -------------

      procedure Release is
      begin
         N := N + 1;
         Not_Empty := (N > 0);
      end Release;

   end Lock;

   ---------
   -- Get --
   ---------

   procedure Get (Item : out Time_Span) is
      I : Integer;

   begin
      Get (I);
      Item := Seconds (I);
   end Get;

   ---------
   -- Get --
   ---------

   procedure Get
     (From : String;
      Item : out Time_Span;
      Last : out Positive)
   is
      S : Integer;
   begin
      Ada.Integer_Text_IO.Get (From, S, Last);
      Item := Seconds (S);
   end Get;

   --------------
   -- New_Line --
   --------------

   procedure New_Line is
   begin
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Flush;
      Lock.Release;
   end New_Line;

   ----------------
   -- Put_Header --
   ----------------

   procedure Put_Header (Item : in String) is
      T : Time_Span := Clock - Activation_Time;
   begin
      Lock.Acquire;
      Put (Item);
      Put (" ");
      if T < Time_Span_Zero then
         T := Time_Span_Zero;
      end if;
      Put (T / One_Second, Width => 2);
      Put (" ");
   end Put_Header;

   -----------------
   -- Put_Natural --
   -----------------

   procedure Put_Natural (Item : in Natural) is
   begin
      Put (Item, Width => 0);
   end Put_Natural;

   ----------------
   -- Put_String --
   ----------------

   procedure Put_String (Item : in String) is
   begin
      Put (Item);
   end Put_String;

   -------------------
   -- Put_Time_Span --
   -------------------

   procedure Put_Time_Span (Item : in Time_Span) is
   begin
     Put (Item / One_Second, Width => 0);
   end Put_Time_Span;

   ---------
   -- NYI --
   ---------

   procedure NYI (Message : String) is
   begin
      Raise_Exception (Not_Yet_Implemented'Identity, Message);
   end NYI;

end IO;

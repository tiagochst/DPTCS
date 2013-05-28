
with Types;

package Probe is

   use Types;

   procedure Read (Read_Value :    out POS_Internal_Type;
		   Field : in out POS_Internal_Type);

   procedure Update (Field : in out POS_Internal_Type);

   procedure GNC_Job;
   procedure TMTC_Job;

   procedure GNC_Identity;
   procedure TMTC_Identity;
   --  At the first call, these subprogram print a welcome message. At
   --  the second call they print a "good bye" message.

   procedure Send_Spg
     (Sent_Data   :     POS_Internal_Type;
      Data_Source : out POS_Internal_Type);
   procedure Receive_Spg (Data_Sink : POS_Internal_Type);

end Probe;

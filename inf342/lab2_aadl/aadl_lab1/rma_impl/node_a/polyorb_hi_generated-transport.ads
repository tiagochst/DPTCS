--------------------------------------------------------
--  This file was automatically generated by Ocarina  --
--  Do NOT hand-modify this file, as your             --
--  changes will be lost when you re-run Ocarina      --
--------------------------------------------------------
pragma Style_Checks
 ("NM32766");

with PolyORB_HI_Generated.Deployment;
with PolyORB_HI.Streams;
with PolyORB_HI.Messages;
with PolyORB_HI.Errors;

--# inherit PolyORB_HI_Generated.Deployment,
--#         PolyORB_HI.Streams,
--#         PolyORB_HI.Messages,
--#         PolyORB_HI.Errors;
package PolyORB_HI_Generated.Transport is

  procedure Deliver
   (Entity : PolyORB_HI_Generated.Deployment.Entity_Type;
    Message : PolyORB_HI.Streams.Stream_Element_Array);

  function Send
   (From : PolyORB_HI_Generated.Deployment.Entity_Type;
    Entity : PolyORB_HI_Generated.Deployment.Entity_Type;
    Message : PolyORB_HI.Messages.Message_Type)
   return PolyORB_HI.Errors.Error_Kind;

end PolyORB_HI_Generated.Transport;

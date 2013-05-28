pragma Source_File_Name (ada_main, Spec_File_Name => "b~node_a.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~node_a.adb");

with System.Restrictions;

package body ada_main is
   pragma Warnings (Off);

   procedure Do_Finalize;
   pragma Import (C, Do_Finalize, "system__standard_library__adafinal");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   procedure adainit is
      E065 : Boolean; pragma Import (Ada, E065, "system__bb__serial_output_E");
      E025 : Boolean; pragma Import (Ada, E025, "system__bb__interrupts_E");
      E057 : Boolean; pragma Import (Ada, E057, "ada__real_time__delays_E");
      E046 : Boolean; pragma Import (Ada, E046, "system__tasking_E");
      E077 : Boolean; pragma Import (Ada, E077, "system__tasking__protected_objects_E");
      E099 : Boolean; pragma Import (Ada, E099, "system__tasking__restricted__stages_E");
      E094 : Boolean; pragma Import (Ada, E094, "computations_E");
      E092 : Boolean; pragma Import (Ada, E092, "hello_E");
      E063 : Boolean; pragma Import (Ada, E063, "polyorb_hi__output_low_level_E");
      E097 : Boolean; pragma Import (Ada, E097, "polyorb_hi__periodic_task_E");
      E006 : Boolean; pragma Import (Ada, E006, "polyorb_hi__suspenders_E");
      E061 : Boolean; pragma Import (Ada, E061, "polyorb_hi__output_E");
      E088 : Boolean; pragma Import (Ada, E088, "polyorb_hi_generated__activity_E");
      E090 : Boolean; pragma Import (Ada, E090, "polyorb_hi_generated__subprograms_E");

      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Zero_Cost_Exceptions : Integer;
      pragma Import (C, Zero_Cost_Exceptions, "__gl_zero_cost_exceptions");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");
   begin
      Main_Priority := 240;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (True, True, False, True, True, True, False, False, 
           True, False, True, True, False, False, True, False, 
           True, False, False, False, False, True, False, False, 
           True, False, False, False, True, False, True, False, 
           True, False, True, True, False, True, False, False, 
           True, True, True, True, False, True, True, False, 
           True, False, False, False, False, False, False, False, 
           False, False, True, True, True, False, True, False, 
           False),
         Value => (1, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, True, False, False, False, True, True, 
           False, False, False, False, False, False, False, True, 
           False, True, False, True, True, False, True, False, 
           False, True, False, False, False, False, False, True, 
           True, False, False, False, True, False, True, False, 
           False, False, False, False, True, False, False, True, 
           False, True, True, False, True, True, True, True, 
           True, True, True, False, False, True, False, True, 
           False),
         Count => (1, 0, 0, 1, 0, 2, 0),
         Unknown => (False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Zero_Cost_Exceptions := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      System.Bb.Serial_Output'Elab_Body;
      E065 := True;
      System.Bb.Interrupts'Elab_Body;
      E025 := True;
      System.Tasking'Elab_Body;
      E046 := True;
      Ada.Real_Time.Delays'Elab_Body;
      E057 := True;
      System.Tasking.Protected_Objects'Elab_Body;
      E077 := True;
      System.Tasking.Restricted.Stages'Elab_Body;
      E099 := True;
      Computations'Elab_Body;
      E094 := True;
      E063 := True;
      Polyorb_Hi.Suspenders'Elab_Spec;
      Polyorb_Hi.Output'Elab_Body;
      E061 := True;
      E006 := True;
      E097 := True;
      E092 := True;
      Polyorb_Hi_Generated.Activity'Elab_Spec;
      E090 := True;
      E088 := True;
   end adainit;

   procedure adafinal is
   begin
      Do_Finalize;
   end adafinal;

   procedure main is
      procedure initialize (Addr : System.Address);
      pragma Import (C, initialize, "__gnat_initialize");

      procedure finalize;
      pragma Import (C, finalize, "__gnat_finalize");

      procedure Ada_Main_Program;
      pragma Import (Ada, Ada_Main_Program, "_ada_node_a");

      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      Initialize (SEH'Address);
      adainit;
      Break_Start;
      Ada_Main_Program;
      Do_Finalize;
      Finalize;
   end;

--  BEGIN Object file/option list
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/computations.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi-errors.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi-output_low_level_leon.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi-streams.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi_generated.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi_generated-deployment.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi-output.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi-suspenders.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi-periodic_task.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/hello.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi_generated-subprograms.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/polyorb_hi_generated-activity.o
   --   /stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/node_a.o
   --   -L/stud/users/promo13/silva/DPTCS/inf342/lab2_aadl/aadl_lab1/rma_impl/node_a/
   --   -L/infres/s3/borde/Install/gnat-gap-2006/lib/gcc/erc32-elf/3.4.6/rts-full/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;

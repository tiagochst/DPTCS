pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~runapsvr.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~runapsvr.adb");

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E107 : Short_Integer; pragma Import (Ada, E107, "system__stack_usage_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exception_table_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "ada__io_exceptions_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__tags_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "ada__streams_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "interfaces__c_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "interfaces__c__strings_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "system__task_info_E");
   E009 : Short_Integer; pragma Import (Ada, E009, "system__secondary_stack_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "system__finalization_root_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "ada__finalization_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "system__storage_pools_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__finalization_masters_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "system__storage_pools__subpools_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__os_lib_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "system__pool_global_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__file_control_block_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__file_io_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "system__tasking__initialization_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "system__tasking__protected_objects_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__real_time_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "ada__text_io_E");
   E184 : Short_Integer; pragma Import (Ada, E184, "system__tasking__protected_objects__entries_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "system__tasking__queuing_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "system__tasking__stages_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "io_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "tasks_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "aperiodic_servers_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "aperiodic_tasks_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "background_servers_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "deferred_servers_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "events_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "periodic_tasks_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "polling_servers_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "scenarii_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "sporadic_servers_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "periodic_tasks__finalize_body");
      begin
         E208 := E208 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "io__finalize_body");
      begin
         E120 := E120 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "tasks__finalize_body");
      begin
         E202 := E202 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "tasks__finalize_spec");
      begin
         F4;
      end;
      E184 := E184 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F5;
      end;
      E124 := E124 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__text_io__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__file_io__finalize_body");
      begin
         E129 := E129 - 1;
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__file_control_block__finalize_spec");
      begin
         E142 := E142 - 1;
         F8;
      end;
      E152 := E152 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__pool_global__finalize_spec");
      begin
         F9;
      end;
      E156 := E156 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__storage_pools__subpools__finalize_spec");
      begin
         F10;
      end;
      E144 := E144 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__finalization_masters__finalize_spec");
      begin
         F11;
      end;
      E133 := E133 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__finalization_root__finalize_spec");
      begin
         F12;
      end;
      if LE_Set then
         declare
            LE : Ada.Exceptions.Exception_Occurrence;
            pragma Import (Ada, LE, "__gnat_library_exception");
            procedure Raise_From_Controlled_Operation (X : Ada.Exceptions.Exception_Occurrence);
            pragma Import (Ada, Raise_From_Controlled_Operation, "__gnat_raise_from_controlled_operation");
         begin
            Raise_From_Controlled_Operation (LE);
         end;
      end if;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
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
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
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
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := 'P';
      Task_Dispatching_Policy := 'F';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, True, False, False, False, False, 
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, False, True, True, False, False, False, False, 
           False, True, True, True, True, False, True, True, 
           False, False, True, True, False, True, True, True, 
           True, True, True, False, True, True, False, True, 
           False, False, False, False, True, True, False, False, 
           True, True, False, False, True, False, False, False, 
           False, False, False, True, False, True, True, True, 
           True, False, True, False, False, True, False, True, 
           True, False, True, True, True, False, True, True, 
           False, False, True, False, True, False),
         Count => (2, 0, 0, 4, 0, 3, 0),
         Unknown => (False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Zero_Cost_Exceptions := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Stack_Usage'Elab_Spec;
      E107 := E107 + 1;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E019 := E019 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E134 := E134 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E125 := E125 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.Task_Info'Elab_Spec;
      E087 := E087 + 1;
      E136 := E136 + 1;
      E070 := E070 + 1;
      Ada.Tags'Elab_Body;
      E048 := E048 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Secondary_Stack'Elab_Body;
      E009 := E009 + 1;
      System.Finalization_Root'Elab_Spec;
      E133 := E133 + 1;
      Ada.Finalization'Elab_Spec;
      E131 := E131 + 1;
      System.Storage_Pools'Elab_Spec;
      E150 := E150 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E144 := E144 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E156 := E156 + 1;
      System.Os_Lib'Elab_Body;
      E139 := E139 + 1;
      System.Pool_Global'Elab_Spec;
      E152 := E152 + 1;
      System.File_Control_Block'Elab_Spec;
      E142 := E142 + 1;
      System.File_Io'Elab_Body;
      E129 := E129 + 1;
      System.Tasking.Initialization'Elab_Body;
      E188 := E188 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E176 := E176 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E061 := E061 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E124 := E124 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E184 := E184 + 1;
      System.Tasking.Queuing'Elab_Body;
      E194 := E194 + 1;
      System.Tasking.Stages'Elab_Body;
      E212 := E212 + 1;
      Tasks'Elab_Spec;
      Tasks'Elab_Body;
      E202 := E202 + 1;
      IO'ELAB_BODY;
      E120 := E120 + 1;
      Aperiodic_Tasks'Elab_Spec;
      E115 := E115 + 1;
      E113 := E113 + 1;
      Deferred_Servers'Elab_Body;
      E214 := E214 + 1;
      E059 := E059 + 1;
      E216 := E216 + 1;
      Scenarii'Elab_Spec;
      E210 := E210 + 1;
      Periodic_Tasks'Elab_Body;
      E208 := E208 + 1;
      E218 := E218 + 1;
      Aperiodic_Servers'Elab_Body;
      E057 := E057 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_runapsvr");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   ./tasks.o
   --   ./io.o
   --   ./aperiodic_tasks.o
   --   ./events.o
   --   ./deferred_servers.o
   --   ./background_servers.o
   --   ./polling_servers.o
   --   ./scenarii.o
   --   ./periodic_tasks.o
   --   ./runapsvr.o
   --   ./sporadic_servers.o
   --   ./aperiodic_servers.o
   --   -L./
   --   -L/usr/lib/gcc/x86_64-redhat-linux/4.7.2/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lpthread
--  END Object file/option list   

end ada_main;

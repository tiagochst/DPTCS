with System;
package ada_main is
   pragma Warnings (Off);


   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2006 (20060522-34)";
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_node_a" & Ascii.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure Break_Start;
   pragma Import (C, Break_Start, "__gnat_break_start");

   procedure main;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#de4a1530#;
   u00002 : constant Version_32 := 16#764ff307#;
   u00003 : constant Version_32 := 16#ae59766b#;
   u00004 : constant Version_32 := 16#cb88b3c7#;
   u00005 : constant Version_32 := 16#ef99ed3a#;
   u00006 : constant Version_32 := 16#035c55bd#;
   u00007 : constant Version_32 := 16#85c20a8d#;
   u00008 : constant Version_32 := 16#3c159438#;
   u00009 : constant Version_32 := 16#9c7dd3ea#;
   u00010 : constant Version_32 := 16#fac15881#;
   u00011 : constant Version_32 := 16#736c8fb5#;
   u00012 : constant Version_32 := 16#11dea053#;
   u00013 : constant Version_32 := 16#a5e1bf4e#;
   u00014 : constant Version_32 := 16#c4549229#;
   u00015 : constant Version_32 := 16#60f858a1#;
   u00016 : constant Version_32 := 16#33bd3917#;
   u00017 : constant Version_32 := 16#264aa8fc#;
   u00018 : constant Version_32 := 16#5d045542#;
   u00019 : constant Version_32 := 16#dedcd7eb#;
   u00020 : constant Version_32 := 16#5c612826#;
   u00021 : constant Version_32 := 16#18f04db3#;
   u00022 : constant Version_32 := 16#da85f938#;
   u00023 : constant Version_32 := 16#f7e9b5a2#;
   u00024 : constant Version_32 := 16#d6233e1c#;
   u00025 : constant Version_32 := 16#1e76af8c#;
   u00026 : constant Version_32 := 16#4ab71ab3#;
   u00027 : constant Version_32 := 16#4702d4e9#;
   u00028 : constant Version_32 := 16#ed562081#;
   u00029 : constant Version_32 := 16#91953827#;
   u00030 : constant Version_32 := 16#a70f2abc#;
   u00031 : constant Version_32 := 16#ae6d5678#;
   u00032 : constant Version_32 := 16#db5c105a#;
   u00033 : constant Version_32 := 16#9c754ccd#;
   u00034 : constant Version_32 := 16#37d58358#;
   u00035 : constant Version_32 := 16#9b27d555#;
   u00036 : constant Version_32 := 16#77cd8ba3#;
   u00037 : constant Version_32 := 16#05453404#;
   u00038 : constant Version_32 := 16#7b5fe8f4#;
   u00039 : constant Version_32 := 16#18626ad5#;
   u00040 : constant Version_32 := 16#5f359b42#;
   u00041 : constant Version_32 := 16#5b5ef7ed#;
   u00042 : constant Version_32 := 16#c7541859#;
   u00043 : constant Version_32 := 16#ff9fd1c6#;
   u00044 : constant Version_32 := 16#f2b1f758#;
   u00045 : constant Version_32 := 16#94a21fc8#;
   u00046 : constant Version_32 := 16#f0affbe3#;
   u00047 : constant Version_32 := 16#2508d210#;
   u00048 : constant Version_32 := 16#ccc54455#;
   u00049 : constant Version_32 := 16#bbb6da21#;
   u00050 : constant Version_32 := 16#30d13d6d#;
   u00051 : constant Version_32 := 16#bbe0c27c#;
   u00052 : constant Version_32 := 16#cbe95fb5#;
   u00053 : constant Version_32 := 16#a69cad5c#;
   u00054 : constant Version_32 := 16#54937b8a#;
   u00055 : constant Version_32 := 16#a1c2a75d#;
   u00056 : constant Version_32 := 16#1879ccff#;
   u00057 : constant Version_32 := 16#a3a46e54#;
   u00058 : constant Version_32 := 16#c02c8054#;
   u00059 : constant Version_32 := 16#7e9e36b0#;
   u00060 : constant Version_32 := 16#9f8ed72d#;
   u00061 : constant Version_32 := 16#24c1472d#;
   u00062 : constant Version_32 := 16#132ed74a#;
   u00063 : constant Version_32 := 16#cb541dd4#;
   u00064 : constant Version_32 := 16#95c4af7a#;
   u00065 : constant Version_32 := 16#6c3ee32c#;
   u00066 : constant Version_32 := 16#45f51a6e#;
   u00067 : constant Version_32 := 16#a58f08e4#;
   u00068 : constant Version_32 := 16#7c0a2101#;
   u00069 : constant Version_32 := 16#050a5fbc#;
   u00070 : constant Version_32 := 16#4135b074#;
   u00071 : constant Version_32 := 16#f04bf624#;
   u00072 : constant Version_32 := 16#e632816f#;
   u00073 : constant Version_32 := 16#e48b7b2d#;
   u00074 : constant Version_32 := 16#63c7c118#;
   u00075 : constant Version_32 := 16#56b30b3d#;
   u00076 : constant Version_32 := 16#85d30e7f#;
   u00077 : constant Version_32 := 16#60d45d15#;
   u00078 : constant Version_32 := 16#def099bd#;
   u00079 : constant Version_32 := 16#373bd87b#;
   u00080 : constant Version_32 := 16#d098c9df#;
   u00081 : constant Version_32 := 16#87dce1f7#;
   u00082 : constant Version_32 := 16#ae6aed8c#;
   u00083 : constant Version_32 := 16#e4445b7e#;
   u00084 : constant Version_32 := 16#8e0aacdc#;
   u00085 : constant Version_32 := 16#5b03ed8a#;
   u00086 : constant Version_32 := 16#ad403b61#;
   u00087 : constant Version_32 := 16#4261bcc3#;
   u00088 : constant Version_32 := 16#273eef62#;
   u00089 : constant Version_32 := 16#cf095b1c#;
   u00090 : constant Version_32 := 16#a492d7e0#;
   u00091 : constant Version_32 := 16#9f633289#;
   u00092 : constant Version_32 := 16#771b71dc#;
   u00093 : constant Version_32 := 16#327d57c2#;
   u00094 : constant Version_32 := 16#7cc91a4f#;
   u00095 : constant Version_32 := 16#00ea8db1#;
   u00096 : constant Version_32 := 16#d958f39d#;
   u00097 : constant Version_32 := 16#c5a288c2#;
   u00098 : constant Version_32 := 16#4cc2a4db#;
   u00099 : constant Version_32 := 16#71504a88#;
   u00100 : constant Version_32 := 16#392e72e2#;
   u00101 : constant Version_32 := 16#a514111f#;
   u00102 : constant Version_32 := 16#f7ece407#;

   pragma Export (C, u00001, "node_aB");
   pragma Export (C, u00002, "system__standard_libraryB");
   pragma Export (C, u00003, "system__standard_libraryS");
   pragma Export (C, u00004, "polyorb_hiS");
   pragma Export (C, u00005, "polyorb_hi__suspendersB");
   pragma Export (C, u00006, "polyorb_hi__suspendersS");
   pragma Export (C, u00007, "ada__exceptionsB");
   pragma Export (C, u00008, "ada__exceptionsS");
   pragma Export (C, u00009, "adaS");
   pragma Export (C, u00010, "ada__exceptions__tracebackB");
   pragma Export (C, u00011, "ada__exceptions__tracebackS");
   pragma Export (C, u00012, "system__secondary_stackB");
   pragma Export (C, u00013, "system__secondary_stackS");
   pragma Export (C, u00014, "systemS");
   pragma Export (C, u00015, "system__storage_elementsB");
   pragma Export (C, u00016, "system__storage_elementsS");
   pragma Export (C, u00017, "system__traceback_entriesB");
   pragma Export (C, u00018, "system__traceback_entriesS");
   pragma Export (C, u00019, "system__soft_linksB");
   pragma Export (C, u00020, "system__soft_linksS");
   pragma Export (C, u00021, "system__task_primitivesS");
   pragma Export (C, u00022, "system__os_interfaceS");
   pragma Export (C, u00023, "system__bbS");
   pragma Export (C, u00024, "system__bb__interruptsB");
   pragma Export (C, u00025, "system__bb__interruptsS");
   pragma Export (C, u00026, "system__bb__cpu_primitivesB");
   pragma Export (C, u00027, "system__bb__cpu_primitivesS");
   pragma Export (C, u00028, "system__bb__parametersS");
   pragma Export (C, u00029, "system__parametersB");
   pragma Export (C, u00030, "system__parametersS");
   pragma Export (C, u00031, "system__bb__threadsB");
   pragma Export (C, u00032, "system__bb__threadsS");
   pragma Export (C, u00033, "system__bb__peripheralsB");
   pragma Export (C, u00034, "system__bb__peripheralsS");
   pragma Export (C, u00035, "system__bb__peripherals__registersS");
   pragma Export (C, u00036, "system__unsigned_typesS");
   pragma Export (C, u00037, "system__bb__protectionB");
   pragma Export (C, u00038, "system__bb__protectionS");
   pragma Export (C, u00039, "system__bb__threads__queuesB");
   pragma Export (C, u00040, "system__bb__threads__queuesS");
   pragma Export (C, u00041, "system__bb__timeB");
   pragma Export (C, u00042, "system__bb__timeS");
   pragma Export (C, u00043, "system__task_primitives__operationsB");
   pragma Export (C, u00044, "system__task_primitives__operationsS");
   pragma Export (C, u00045, "system__taskingB");
   pragma Export (C, u00046, "system__taskingS");
   pragma Export (C, u00047, "system__task_infoB");
   pragma Export (C, u00048, "system__task_infoS");
   pragma Export (C, u00049, "system__tasking__debugB");
   pragma Export (C, u00050, "system__tasking__debugS");
   pragma Export (C, u00051, "system__tracebackB");
   pragma Export (C, u00052, "system__tracebackS");
   pragma Export (C, u00053, "interfacesS");
   pragma Export (C, u00054, "interfaces__cS");
   pragma Export (C, u00055, "system__machine_codeS");
   pragma Export (C, u00056, "ada__real_time__delaysB");
   pragma Export (C, u00057, "ada__real_time__delaysS");
   pragma Export (C, u00058, "ada__real_timeB");
   pragma Export (C, u00059, "ada__real_timeS");
   pragma Export (C, u00060, "polyorb_hi__outputB");
   pragma Export (C, u00061, "polyorb_hi__outputS");
   pragma Export (C, u00062, "polyorb_hi__output_low_levelB");
   pragma Export (C, u00063, "polyorb_hi__output_low_levelS");
   pragma Export (C, u00064, "system__bb__serial_outputB");
   pragma Export (C, u00065, "system__bb__serial_outputS");
   pragma Export (C, u00066, "system__img_realB");
   pragma Export (C, u00067, "system__img_realS");
   pragma Export (C, u00068, "system__fat_llfS");
   pragma Export (C, u00069, "system__img_lluB");
   pragma Export (C, u00070, "system__img_lluS");
   pragma Export (C, u00071, "system__img_unsB");
   pragma Export (C, u00072, "system__img_unsS");
   pragma Export (C, u00073, "system__powten_tableS");
   pragma Export (C, u00074, "system__string_opsB");
   pragma Export (C, u00075, "system__string_opsS");
   pragma Export (C, u00076, "system__tasking__protected_objectsB");
   pragma Export (C, u00077, "system__tasking__protected_objectsS");
   pragma Export (C, u00078, "polyorb_hi__streamsS");
   pragma Export (C, u00079, "system__string_ops_concat_3B");
   pragma Export (C, u00080, "system__string_ops_concat_3S");
   pragma Export (C, u00081, "ada__synchronous_task_controlB");
   pragma Export (C, u00082, "ada__synchronous_task_controlS");
   pragma Export (C, u00083, "system__tasking__protected_objects__single_entryB");
   pragma Export (C, u00084, "system__tasking__protected_objects__single_entryS");
   pragma Export (C, u00085, "polyorb_hi_generatedS");
   pragma Export (C, u00086, "polyorb_hi_generated__deploymentS");
   pragma Export (C, u00087, "polyorb_hi_generated__activityB");
   pragma Export (C, u00088, "polyorb_hi_generated__activityS");
   pragma Export (C, u00089, "polyorb_hi_generated__subprogramsB");
   pragma Export (C, u00090, "polyorb_hi_generated__subprogramsS");
   pragma Export (C, u00091, "helloB");
   pragma Export (C, u00092, "helloS");
   pragma Export (C, u00093, "computationsB");
   pragma Export (C, u00094, "computationsS");
   pragma Export (C, u00095, "polyorb_hi__errorsS");
   pragma Export (C, u00096, "polyorb_hi__periodic_taskB");
   pragma Export (C, u00097, "polyorb_hi__periodic_taskS");
   pragma Export (C, u00098, "system__tasking__restricted__stagesB");
   pragma Export (C, u00099, "system__tasking__restricted__stagesS");
   pragma Export (C, u00100, "system__tasking__restrictedS");
   pragma Export (C, u00101, "system__memoryB");
   pragma Export (C, u00102, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  interfaces.c%s
   --  system%s
   --  system.bb%s
   --  system.bb.protection%s
   --  system.bb.serial_output%s
   --  system.img_real%s
   --  system.machine_code%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.bb.parameters%s
   --  system.bb.cpu_primitives%s
   --  system.bb.peripherals%s
   --  system.bb.serial_output%b
   --  system.bb.interrupts%s
   --  system.bb.time%s
   --  system.bb.threads%s
   --  system.bb.threads.queues%s
   --  system.bb.threads.queues%b
   --  system.bb.time%b
   --  system.bb.protection%b
   --  system.powten_table%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.bb.threads%b
   --  system.bb.interrupts%b
   --  system.bb.cpu_primitives%b
   --  system.os_interface%s
   --  ada.real_time%s
   --  ada.real_time.delays%s
   --  system.secondary_stack%s
   --  system.secondary_stack%b
   --  system.string_ops%s
   --  system.string_ops%b
   --  system.string_ops_concat_3%s
   --  system.string_ops_concat_3%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking%b
   --  ada.real_time.delays%b
   --  ada.real_time%b
   --  system.soft_links%b
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.single_entry%s
   --  system.tasking.protected_objects.single_entry%b
   --  ada.synchronous_task_control%s
   --  ada.synchronous_task_control%b
   --  system.tasking.restricted%s
   --  system.tasking.restricted.stages%s
   --  system.tasking.restricted.stages%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.exceptions%b
   --  system.unsigned_types%s
   --  system.bb.peripherals.registers%s
   --  system.bb.peripherals%b
   --  system.fat_llf%s
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  computations%s
   --  computations%b
   --  hello%s
   --  polyorb_hi%s
   --  polyorb_hi.errors%s
   --  polyorb_hi.output_low_level%s
   --  polyorb_hi.output_low_level%b
   --  polyorb_hi.streams%s
   --  polyorb_hi_generated%s
   --  polyorb_hi_generated.deployment%s
   --  polyorb_hi.periodic_task%s
   --  polyorb_hi.suspenders%s
   --  polyorb_hi.output%s
   --  polyorb_hi.output%b
   --  polyorb_hi.suspenders%b
   --  polyorb_hi.periodic_task%b
   --  hello%b
   --  polyorb_hi_generated.activity%s
   --  polyorb_hi_generated.subprograms%s
   --  polyorb_hi_generated.subprograms%b
   --  polyorb_hi_generated.activity%b
   --  node_a%b
   --  END ELABORATION ORDER

end ada_main;

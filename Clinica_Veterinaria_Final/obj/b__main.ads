pragma Ada_95;
pragma Warnings (Off);
with System;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2016 (20160515-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#bdc89433#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#b6df930e#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#937076cc#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#e51537a7#;
   pragma Export (C, u00005, "ada__command_lineB");
   u00006 : constant Version_32 := 16#d59e21a4#;
   pragma Export (C, u00006, "ada__command_lineS");
   u00007 : constant Version_32 := 16#6326c08a#;
   pragma Export (C, u00007, "systemS");
   u00008 : constant Version_32 := 16#0f0cb66d#;
   pragma Export (C, u00008, "system__secondary_stackB");
   u00009 : constant Version_32 := 16#c8470fe3#;
   pragma Export (C, u00009, "system__secondary_stackS");
   u00010 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00010, "system__parametersB");
   u00011 : constant Version_32 := 16#1d0ccdf5#;
   pragma Export (C, u00011, "system__parametersS");
   u00012 : constant Version_32 := 16#5f84b5ab#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#fda218df#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#e7214354#;
   pragma Export (C, u00014, "ada__exceptionsB");
   u00015 : constant Version_32 := 16#020f9e08#;
   pragma Export (C, u00015, "ada__exceptionsS");
   u00016 : constant Version_32 := 16#e947e6a9#;
   pragma Export (C, u00016, "ada__exceptions__last_chance_handlerB");
   u00017 : constant Version_32 := 16#41e5552e#;
   pragma Export (C, u00017, "ada__exceptions__last_chance_handlerS");
   u00018 : constant Version_32 := 16#87a448ff#;
   pragma Export (C, u00018, "system__exception_tableB");
   u00019 : constant Version_32 := 16#3e88a9c8#;
   pragma Export (C, u00019, "system__exception_tableS");
   u00020 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00020, "system__exceptionsB");
   u00021 : constant Version_32 := 16#0b45ad7c#;
   pragma Export (C, u00021, "system__exceptionsS");
   u00022 : constant Version_32 := 16#4c9e814d#;
   pragma Export (C, u00022, "system__exceptions__machineS");
   u00023 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00023, "system__exceptions_debugB");
   u00024 : constant Version_32 := 16#1dac394e#;
   pragma Export (C, u00024, "system__exceptions_debugS");
   u00025 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00025, "system__img_intB");
   u00026 : constant Version_32 := 16#61fd2048#;
   pragma Export (C, u00026, "system__img_intS");
   u00027 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00027, "system__storage_elementsB");
   u00028 : constant Version_32 := 16#4ee58a8e#;
   pragma Export (C, u00028, "system__storage_elementsS");
   u00029 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00029, "system__tracebackB");
   u00030 : constant Version_32 := 16#3d041e4e#;
   pragma Export (C, u00030, "system__tracebackS");
   u00031 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00031, "system__traceback_entriesB");
   u00032 : constant Version_32 := 16#637d36fa#;
   pragma Export (C, u00032, "system__traceback_entriesS");
   u00033 : constant Version_32 := 16#0162f862#;
   pragma Export (C, u00033, "system__traceback__symbolicB");
   u00034 : constant Version_32 := 16#dd19f67a#;
   pragma Export (C, u00034, "system__traceback__symbolicS");
   u00035 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00035, "ada__exceptions__tracebackB");
   u00036 : constant Version_32 := 16#20245e75#;
   pragma Export (C, u00036, "ada__exceptions__tracebackS");
   u00037 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00037, "interfacesS");
   u00038 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00038, "interfaces__cB");
   u00039 : constant Version_32 := 16#70be4e8c#;
   pragma Export (C, u00039, "interfaces__cS");
   u00040 : constant Version_32 := 16#5f72f755#;
   pragma Export (C, u00040, "system__address_operationsB");
   u00041 : constant Version_32 := 16#702a7eb9#;
   pragma Export (C, u00041, "system__address_operationsS");
   u00042 : constant Version_32 := 16#13b71684#;
   pragma Export (C, u00042, "system__crtlS");
   u00043 : constant Version_32 := 16#f82008fb#;
   pragma Export (C, u00043, "system__dwarf_linesB");
   u00044 : constant Version_32 := 16#0aa7ccc7#;
   pragma Export (C, u00044, "system__dwarf_linesS");
   u00045 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00045, "ada__charactersS");
   u00046 : constant Version_32 := 16#8f637df8#;
   pragma Export (C, u00046, "ada__characters__handlingB");
   u00047 : constant Version_32 := 16#3b3f6154#;
   pragma Export (C, u00047, "ada__characters__handlingS");
   u00048 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00048, "ada__characters__latin_1S");
   u00049 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00049, "ada__stringsS");
   u00050 : constant Version_32 := 16#e2ea8656#;
   pragma Export (C, u00050, "ada__strings__mapsB");
   u00051 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00051, "ada__strings__mapsS");
   u00052 : constant Version_32 := 16#04ec3c16#;
   pragma Export (C, u00052, "system__bit_opsB");
   u00053 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00053, "system__bit_opsS");
   u00054 : constant Version_32 := 16#57a0bc09#;
   pragma Export (C, u00054, "system__unsigned_typesS");
   u00055 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00055, "ada__strings__maps__constantsS");
   u00056 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00056, "system__address_imageB");
   u00057 : constant Version_32 := 16#c2ca5db0#;
   pragma Export (C, u00057, "system__address_imageS");
   u00058 : constant Version_32 := 16#ec78c2bf#;
   pragma Export (C, u00058, "system__img_unsB");
   u00059 : constant Version_32 := 16#c85480fe#;
   pragma Export (C, u00059, "system__img_unsS");
   u00060 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00060, "system__ioB");
   u00061 : constant Version_32 := 16#fd6437c5#;
   pragma Export (C, u00061, "system__ioS");
   u00062 : constant Version_32 := 16#cf909744#;
   pragma Export (C, u00062, "system__object_readerB");
   u00063 : constant Version_32 := 16#27c18a1d#;
   pragma Export (C, u00063, "system__object_readerS");
   u00064 : constant Version_32 := 16#1a74a354#;
   pragma Export (C, u00064, "system__val_lliB");
   u00065 : constant Version_32 := 16#f902262a#;
   pragma Export (C, u00065, "system__val_lliS");
   u00066 : constant Version_32 := 16#afdbf393#;
   pragma Export (C, u00066, "system__val_lluB");
   u00067 : constant Version_32 := 16#2d52eb7b#;
   pragma Export (C, u00067, "system__val_lluS");
   u00068 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00068, "system__val_utilB");
   u00069 : constant Version_32 := 16#cf867674#;
   pragma Export (C, u00069, "system__val_utilS");
   u00070 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00070, "system__case_utilB");
   u00071 : constant Version_32 := 16#472fa95d#;
   pragma Export (C, u00071, "system__case_utilS");
   u00072 : constant Version_32 := 16#84a27f0d#;
   pragma Export (C, u00072, "interfaces__c_streamsB");
   u00073 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00073, "interfaces__c_streamsS");
   u00074 : constant Version_32 := 16#931ff6be#;
   pragma Export (C, u00074, "system__exception_tracesB");
   u00075 : constant Version_32 := 16#47f9e010#;
   pragma Export (C, u00075, "system__exception_tracesS");
   u00076 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00076, "system__wch_conB");
   u00077 : constant Version_32 := 16#785be258#;
   pragma Export (C, u00077, "system__wch_conS");
   u00078 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00078, "system__wch_stwB");
   u00079 : constant Version_32 := 16#554ace59#;
   pragma Export (C, u00079, "system__wch_stwS");
   u00080 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00080, "system__wch_cnvB");
   u00081 : constant Version_32 := 16#77ec58ab#;
   pragma Export (C, u00081, "system__wch_cnvS");
   u00082 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00082, "system__wch_jisB");
   u00083 : constant Version_32 := 16#f79c418a#;
   pragma Export (C, u00083, "system__wch_jisS");
   u00084 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00084, "system__stack_checkingB");
   u00085 : constant Version_32 := 16#ed99ab62#;
   pragma Export (C, u00085, "system__stack_checkingS");
   u00086 : constant Version_32 := 16#5130abd7#;
   pragma Export (C, u00086, "ada__strings__unboundedB");
   u00087 : constant Version_32 := 16#4c956ffe#;
   pragma Export (C, u00087, "ada__strings__unboundedS");
   u00088 : constant Version_32 := 16#45c9251c#;
   pragma Export (C, u00088, "ada__strings__searchB");
   u00089 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00089, "ada__strings__searchS");
   u00090 : constant Version_32 := 16#920eada5#;
   pragma Export (C, u00090, "ada__tagsB");
   u00091 : constant Version_32 := 16#13ca27f3#;
   pragma Export (C, u00091, "ada__tagsS");
   u00092 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00092, "system__htableB");
   u00093 : constant Version_32 := 16#e7e47360#;
   pragma Export (C, u00093, "system__htableS");
   u00094 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00094, "system__string_hashB");
   u00095 : constant Version_32 := 16#45ba181e#;
   pragma Export (C, u00095, "system__string_hashS");
   u00096 : constant Version_32 := 16#5b9edcc4#;
   pragma Export (C, u00096, "system__compare_array_unsigned_8B");
   u00097 : constant Version_32 := 16#ca25b107#;
   pragma Export (C, u00097, "system__compare_array_unsigned_8S");
   u00098 : constant Version_32 := 16#6a86c9a5#;
   pragma Export (C, u00098, "system__storage_pools__subpoolsB");
   u00099 : constant Version_32 := 16#cc5a1856#;
   pragma Export (C, u00099, "system__storage_pools__subpoolsS");
   u00100 : constant Version_32 := 16#6abe5dbe#;
   pragma Export (C, u00100, "system__finalization_mastersB");
   u00101 : constant Version_32 := 16#38daf940#;
   pragma Export (C, u00101, "system__finalization_mastersS");
   u00102 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00102, "system__img_boolB");
   u00103 : constant Version_32 := 16#96ffb161#;
   pragma Export (C, u00103, "system__img_boolS");
   u00104 : constant Version_32 := 16#cf417de3#;
   pragma Export (C, u00104, "ada__finalizationS");
   u00105 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00105, "ada__streamsB");
   u00106 : constant Version_32 := 16#2e6701ab#;
   pragma Export (C, u00106, "ada__streamsS");
   u00107 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00107, "ada__io_exceptionsS");
   u00108 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00108, "system__finalization_rootB");
   u00109 : constant Version_32 := 16#2cd4b31a#;
   pragma Export (C, u00109, "system__finalization_rootS");
   u00110 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00110, "system__storage_poolsB");
   u00111 : constant Version_32 := 16#40cb5e27#;
   pragma Export (C, u00111, "system__storage_poolsS");
   u00112 : constant Version_32 := 16#9aad1ff1#;
   pragma Export (C, u00112, "system__storage_pools__subpools__finalizationB");
   u00113 : constant Version_32 := 16#fe2f4b3a#;
   pragma Export (C, u00113, "system__storage_pools__subpools__finalizationS");
   u00114 : constant Version_32 := 16#020a3f4d#;
   pragma Export (C, u00114, "system__atomic_countersB");
   u00115 : constant Version_32 := 16#d77aed07#;
   pragma Export (C, u00115, "system__atomic_countersS");
   u00116 : constant Version_32 := 16#f4e1c091#;
   pragma Export (C, u00116, "system__stream_attributesB");
   u00117 : constant Version_32 := 16#8bc30a4e#;
   pragma Export (C, u00117, "system__stream_attributesS");
   u00118 : constant Version_32 := 16#d5bfa9f3#;
   pragma Export (C, u00118, "ada__text_ioB");
   u00119 : constant Version_32 := 16#8d734ca7#;
   pragma Export (C, u00119, "ada__text_ioS");
   u00120 : constant Version_32 := 16#b29d05bd#;
   pragma Export (C, u00120, "system__file_ioB");
   u00121 : constant Version_32 := 16#c45721ef#;
   pragma Export (C, u00121, "system__file_ioS");
   u00122 : constant Version_32 := 16#d3560627#;
   pragma Export (C, u00122, "system__os_libB");
   u00123 : constant Version_32 := 16#bf5ce13f#;
   pragma Export (C, u00123, "system__os_libS");
   u00124 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00124, "system__stringsB");
   u00125 : constant Version_32 := 16#1d99d1ec#;
   pragma Export (C, u00125, "system__stringsS");
   u00126 : constant Version_32 := 16#9eb95a22#;
   pragma Export (C, u00126, "system__file_control_blockS");
   u00127 : constant Version_32 := 16#431a8743#;
   pragma Export (C, u00127, "clinica_veterinariaB");
   u00128 : constant Version_32 := 16#f238b3da#;
   pragma Export (C, u00128, "clinica_veterinariaS");
   u00129 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00129, "system__concat_2B");
   u00130 : constant Version_32 := 16#6186175a#;
   pragma Export (C, u00130, "system__concat_2S");
   u00131 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00131, "system__concat_3B");
   u00132 : constant Version_32 := 16#68569c2f#;
   pragma Export (C, u00132, "system__concat_3S");
   u00133 : constant Version_32 := 16#932a4690#;
   pragma Export (C, u00133, "system__concat_4B");
   u00134 : constant Version_32 := 16#1d42ebaa#;
   pragma Export (C, u00134, "system__concat_4S");
   u00135 : constant Version_32 := 16#78cb869e#;
   pragma Export (C, u00135, "system__concat_9B");
   u00136 : constant Version_32 := 16#bf6cf4ae#;
   pragma Export (C, u00136, "system__concat_9S");
   u00137 : constant Version_32 := 16#46b1f5ea#;
   pragma Export (C, u00137, "system__concat_8B");
   u00138 : constant Version_32 := 16#80218d5d#;
   pragma Export (C, u00138, "system__concat_8S");
   u00139 : constant Version_32 := 16#46899fd1#;
   pragma Export (C, u00139, "system__concat_7B");
   u00140 : constant Version_32 := 16#9fe19b95#;
   pragma Export (C, u00140, "system__concat_7S");
   u00141 : constant Version_32 := 16#a83b7c85#;
   pragma Export (C, u00141, "system__concat_6B");
   u00142 : constant Version_32 := 16#b1e1ed38#;
   pragma Export (C, u00142, "system__concat_6S");
   u00143 : constant Version_32 := 16#608e2cd1#;
   pragma Export (C, u00143, "system__concat_5B");
   u00144 : constant Version_32 := 16#e47883a4#;
   pragma Export (C, u00144, "system__concat_5S");
   u00145 : constant Version_32 := 16#d0432c8d#;
   pragma Export (C, u00145, "system__img_enum_newB");
   u00146 : constant Version_32 := 16#026ac64a#;
   pragma Export (C, u00146, "system__img_enum_newS");
   u00147 : constant Version_32 := 16#5a895de2#;
   pragma Export (C, u00147, "system__pool_globalB");
   u00148 : constant Version_32 := 16#7141203e#;
   pragma Export (C, u00148, "system__pool_globalS");
   u00149 : constant Version_32 := 16#a6359005#;
   pragma Export (C, u00149, "system__memoryB");
   u00150 : constant Version_32 := 16#3a5ba6be#;
   pragma Export (C, u00150, "system__memoryS");
   u00151 : constant Version_32 := 16#79fa9657#;
   pragma Export (C, u00151, "constantsS");
   u00152 : constant Version_32 := 16#e1edabe8#;
   pragma Export (C, u00152, "d_listB");
   u00153 : constant Version_32 := 16#df875c39#;
   pragma Export (C, u00153, "d_listS");
   u00154 : constant Version_32 := 16#77a25478#;
   pragma Export (C, u00154, "hash_mapB");
   u00155 : constant Version_32 := 16#96bb1442#;
   pragma Export (C, u00155, "hash_mapS");
   u00156 : constant Version_32 := 16#c29e1d8f#;
   pragma Export (C, u00156, "out_sysB");
   u00157 : constant Version_32 := 16#ea802e49#;
   pragma Export (C, u00157, "out_sysS");
   u00158 : constant Version_32 := 16#c2647521#;
   pragma Export (C, u00158, "system__direct_ioB");
   u00159 : constant Version_32 := 16#c14726b4#;
   pragma Export (C, u00159, "system__direct_ioS");
   u00160 : constant Version_32 := 16#c4cbf948#;
   pragma Export (C, u00160, "priority_queueB");
   u00161 : constant Version_32 := 16#e4d4102a#;
   pragma Export (C, u00161, "priority_queueS");
   u00162 : constant Version_32 := 16#c398cc6a#;
   pragma Export (C, u00162, "registre_visitesB");
   u00163 : constant Version_32 := 16#285aa38b#;
   pragma Export (C, u00163, "registre_visitesS");
   u00164 : constant Version_32 := 16#f6c68574#;
   pragma Export (C, u00164, "d_dauB");
   u00165 : constant Version_32 := 16#692c37e1#;
   pragma Export (C, u00165, "d_dauS");
   u00166 : constant Version_32 := 16#84ad4a42#;
   pragma Export (C, u00166, "ada__numericsS");
   u00167 : constant Version_32 := 16#1bec56b8#;
   pragma Export (C, u00167, "system__random_numbersB");
   u00168 : constant Version_32 := 16#a03e7010#;
   pragma Export (C, u00168, "system__random_numbersS");
   u00169 : constant Version_32 := 16#880b169f#;
   pragma Export (C, u00169, "system__random_seedB");
   u00170 : constant Version_32 := 16#3836e9d1#;
   pragma Export (C, u00170, "system__random_seedS");
   u00171 : constant Version_32 := 16#c5dcd3d2#;
   pragma Export (C, u00171, "ada__calendarB");
   u00172 : constant Version_32 := 16#12a38fcc#;
   pragma Export (C, u00172, "ada__calendarS");
   u00173 : constant Version_32 := 16#d083f760#;
   pragma Export (C, u00173, "system__os_primitivesB");
   u00174 : constant Version_32 := 16#e9a9d1fc#;
   pragma Export (C, u00174, "system__os_primitivesS");
   u00175 : constant Version_32 := 16#1d9142a4#;
   pragma Export (C, u00175, "system__val_unsB");
   u00176 : constant Version_32 := 16#47085132#;
   pragma Export (C, u00176, "system__val_unsS");
   u00177 : constant Version_32 := 16#d763507a#;
   pragma Export (C, u00177, "system__val_intB");
   u00178 : constant Version_32 := 16#2b83eab5#;
   pragma Export (C, u00178, "system__val_intS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  ada.command_line%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.case_util%s
   --  system.case_util%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.os_lib%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.unsigned_types%s
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.val_int%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.val_int%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  system.address_image%s
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.concat_5%s
   --  system.concat_5%b
   --  system.concat_6%s
   --  system.concat_6%b
   --  system.concat_7%s
   --  system.concat_7%b
   --  system.concat_8%s
   --  system.concat_8%b
   --  system.concat_9%s
   --  system.concat_9%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps.constants%s
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.tags%s
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.file_control_block%s
   --  system.file_io%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  system.direct_io%s
   --  system.direct_io%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.object_reader%s
   --  system.dwarf_lines%s
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.random_numbers%s
   --  system.random_seed%s
   --  system.random_seed%b
   --  system.secondary_stack%s
   --  system.storage_pools.subpools%b
   --  system.finalization_masters%b
   --  system.file_io%b
   --  interfaces.c%b
   --  ada.tags%b
   --  ada.strings.maps%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  ada.command_line%b
   --  ada.characters.handling%b
   --  system.secondary_stack%b
   --  system.random_numbers%b
   --  system.dwarf_lines%b
   --  system.object_reader%b
   --  system.address_image%b
   --  ada.exceptions.traceback%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  constants%s
   --  d_dau%s
   --  d_dau%b
   --  d_list%s
   --  d_list%b
   --  hash_map%s
   --  hash_map%b
   --  out_sys%s
   --  out_sys%b
   --  priority_queue%s
   --  priority_queue%b
   --  registre_visites%s
   --  registre_visites%b
   --  clinica_veterinaria%s
   --  clinica_veterinaria%b
   --  main%b
   --  END ELABORATION ORDER


end ada_main;

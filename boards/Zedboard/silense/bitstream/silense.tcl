
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-1
   set_property BOARD_PART em.avnet.com:zed:part0:1.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
user.org:user:STHV1600:2.0\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:processing_system7:5.5\
xilinx.com:ip:proc_sys_reset:5.0\
user.org:user:silense_FSM:1.0\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
user.org:user:ltc234416:1.0\
user.org:user:subtract_block:1.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: hier_test_bram3
proc create_hier_cell_hier_test_bram3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_test_bram3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_PORTB

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_test_bram2
proc create_hier_cell_hier_test_bram2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_test_bram2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_PORTB

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_test_bram1
proc create_hier_cell_hier_test_bram1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_test_bram1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_PORTB

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_test_bram
proc create_hier_cell_hier_test_bram { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_test_bram() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_PORTB

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: adc_subtr_4_3
proc create_hier_cell_adc_subtr_4_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_adc_subtr_4_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_32

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I busy_0
  create_bd_pin -dir I calibn
  create_bd_pin -dir O cnv_0
  create_bd_pin -dir O -from 3 -to 0 detection
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -type rst s00_axi_aresetn
  create_bd_pin -dir O sample_donen
  create_bd_pin -dir O -type clk scki_0
  create_bd_pin -dir O sdi_0
  create_bd_pin -dir I -from 11 -to 0 sdi_config
  create_bd_pin -dir I -from 3 -to 0 sdo_0
  create_bd_pin -dir I startn
  create_bd_pin -dir O subtr_donen

  # Create instance: axi_bram_ctrl_0_bram0, and set properties
  set axi_bram_ctrl_0_bram0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram0

  # Create instance: axi_bram_ctrl_0_bram1, and set properties
  set axi_bram_ctrl_0_bram1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram1 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram1

  # Create instance: axi_bram_ctrl_0_bram2, and set properties
  set axi_bram_ctrl_0_bram2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram2 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram2

  # Create instance: axi_bram_ctrl_0_bram3, and set properties
  set axi_bram_ctrl_0_bram3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram3 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram3

  # Create instance: ltc234416_0, and set properties
  set ltc234416_0 [ create_bd_cell -type ip -vlnv user.org:user:ltc234416:1.0 ltc234416_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.cnv_clk_cycles {5} \
   CONFIG.debug {true} \
   CONFIG.subtr_offset {400} \
 ] $ltc234416_0

  # Create instance: subtract_block_0, and set properties
  set subtract_block_0 [ create_bd_cell -type ip -vlnv user.org:user:subtract_block:1.0 subtract_block_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.debug {true} \
   CONFIG.subtr_offset {400} \
 ] $subtract_block_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins subtract_block_0/S00_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins BRAM_32] [get_bd_intf_pins ltc234416_0/BRAM_32]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM0]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM1]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM2]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM3]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM0]
  connect_bd_intf_net -intf_net [get_bd_intf_nets subtract_block_0_BRAM0] [get_bd_intf_pins BRAM0] [get_bd_intf_pins subtract_block_0/BRAM0]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets subtract_block_0_BRAM0]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM1]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM2]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM3]

  # Create port connections
  connect_bd_net -net busy_0_1 [get_bd_pins busy_0] [get_bd_pins ltc234416_0/busy]
  connect_bd_net -net cal0_debug [get_bd_pins subtract_block_0/cal0_debug]
  connect_bd_net -net cal1_debug [get_bd_pins subtract_block_0/cal1_debug]
  connect_bd_net -net calibn_1 [get_bd_pins calibn] [get_bd_pins ltc234416_0/calibn]
  connect_bd_net -net ch0_o [get_bd_pins ltc234416_0/ch0_o]
  connect_bd_net -net ch1_o [get_bd_pins ltc234416_0/ch1_o]
  connect_bd_net -net ch2_o [get_bd_pins ltc234416_0/ch2_o]
  connect_bd_net -net ch3_o [get_bd_pins ltc234416_0/ch3_o]
  connect_bd_net -net counter_debug [get_bd_pins subtract_block_0/counter_debug]
  connect_bd_net -net ltc234416_0_cnv [get_bd_pins cnv_0] [get_bd_pins ltc234416_0/cnv]
  connect_bd_net -net ltc234416_0_sample_donen [get_bd_pins sample_donen] [get_bd_pins ltc234416_0/sample_donen]
  connect_bd_net -net ltc234416_0_scki [get_bd_pins scki_0] [get_bd_pins ltc234416_0/scki]
  connect_bd_net -net ltc234416_0_sdi [get_bd_pins sdi_0] [get_bd_pins ltc234416_0/sdi]
  connect_bd_net -net ltc234416_0_startn_subtr [get_bd_pins ltc234416_0/startn_subtr] [get_bd_pins subtract_block_0/startn]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins s00_axi_aclk] [get_bd_pins ltc234416_0/clk] [get_bd_pins subtract_block_0/s00_axi_aclk]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins s00_axi_aresetn] [get_bd_pins ltc234416_0/resetn] [get_bd_pins subtract_block_0/s00_axi_aresetn]
  connect_bd_net -net sdi_config_1 [get_bd_pins sdi_config] [get_bd_pins ltc234416_0/sdi_config]
  connect_bd_net -net sdo_0_1 [get_bd_pins sdo_0] [get_bd_pins ltc234416_0/sdo]
  connect_bd_net -net startn_1 [get_bd_pins startn] [get_bd_pins ltc234416_0/startn]
  connect_bd_net -net subtr0_debug [get_bd_pins subtract_block_0/subtr0_debug]
  connect_bd_net -net subtr1_debug [get_bd_pins subtract_block_0/subtr1_debug]
  connect_bd_net -net subtract_block_0_detection [get_bd_pins detection] [get_bd_pins subtract_block_0/detection]
  connect_bd_net -net subtract_block_0_subtr_donen [get_bd_pins subtr_donen] [get_bd_pins subtract_block_0/subtr_donen]
  connect_bd_net -net val0_debug [get_bd_pins subtract_block_0/val0_debug]
  connect_bd_net -net val1_debug [get_bd_pins subtract_block_0/val1_debug]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: adc_subtr_4_2
proc create_hier_cell_adc_subtr_4_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_adc_subtr_4_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_32

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I busy_0
  create_bd_pin -dir I calibn
  create_bd_pin -dir O cnv_0
  create_bd_pin -dir O -from 3 -to 0 detection
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -type rst s00_axi_aresetn
  create_bd_pin -dir O sample_donen
  create_bd_pin -dir O -type clk scki_0
  create_bd_pin -dir O sdi_0
  create_bd_pin -dir I -from 11 -to 0 sdi_config
  create_bd_pin -dir I -from 3 -to 0 sdo_0
  create_bd_pin -dir I startn
  create_bd_pin -dir O startn_subtr
  create_bd_pin -dir O subtr_donen

  # Create instance: axi_bram_ctrl_0_bram0, and set properties
  set axi_bram_ctrl_0_bram0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram0

  # Create instance: axi_bram_ctrl_0_bram1, and set properties
  set axi_bram_ctrl_0_bram1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram1 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram1

  # Create instance: axi_bram_ctrl_0_bram2, and set properties
  set axi_bram_ctrl_0_bram2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram2 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram2

  # Create instance: axi_bram_ctrl_0_bram3, and set properties
  set axi_bram_ctrl_0_bram3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram3 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram3

  # Create instance: ltc234416_0, and set properties
  set ltc234416_0 [ create_bd_cell -type ip -vlnv user.org:user:ltc234416:1.0 ltc234416_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.cnv_clk_cycles {5} \
   CONFIG.debug {false} \
   CONFIG.subtr_offset {400} \
 ] $ltc234416_0

  # Create instance: subtract_block_0, and set properties
  set subtract_block_0 [ create_bd_cell -type ip -vlnv user.org:user:subtract_block:1.0 subtract_block_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.debug {false} \
   CONFIG.subtr_offset {400} \
 ] $subtract_block_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins subtract_block_0/S00_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins BRAM_32] [get_bd_intf_pins ltc234416_0/BRAM_32]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM0]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM1]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM2]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM3]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM0]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM1]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM2]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM3]

  # Create port connections
  connect_bd_net -net busy_0_1 [get_bd_pins busy_0] [get_bd_pins ltc234416_0/busy]
  connect_bd_net -net calibn_1 [get_bd_pins calibn] [get_bd_pins ltc234416_0/calibn]
  connect_bd_net -net ltc234416_0_cnv [get_bd_pins cnv_0] [get_bd_pins ltc234416_0/cnv]
  connect_bd_net -net ltc234416_0_sample_donen [get_bd_pins sample_donen] [get_bd_pins ltc234416_0/sample_donen]
  connect_bd_net -net ltc234416_0_scki [get_bd_pins scki_0] [get_bd_pins ltc234416_0/scki]
  connect_bd_net -net ltc234416_0_sdi [get_bd_pins sdi_0] [get_bd_pins ltc234416_0/sdi]
  connect_bd_net -net ltc234416_0_startn_subtr [get_bd_pins startn_subtr] [get_bd_pins ltc234416_0/startn_subtr] [get_bd_pins subtract_block_0/startn]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins s00_axi_aclk] [get_bd_pins ltc234416_0/clk] [get_bd_pins subtract_block_0/s00_axi_aclk]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins s00_axi_aresetn] [get_bd_pins ltc234416_0/resetn] [get_bd_pins subtract_block_0/s00_axi_aresetn]
  connect_bd_net -net sdi_config_1 [get_bd_pins sdi_config] [get_bd_pins ltc234416_0/sdi_config]
  connect_bd_net -net sdo_0_1 [get_bd_pins sdo_0] [get_bd_pins ltc234416_0/sdo]
  connect_bd_net -net startn_1 [get_bd_pins startn] [get_bd_pins ltc234416_0/startn]
  connect_bd_net -net subtract_block_0_detection [get_bd_pins detection] [get_bd_pins subtract_block_0/detection]
  connect_bd_net -net subtract_block_0_subtr_donen [get_bd_pins subtr_donen] [get_bd_pins subtract_block_0/subtr_donen]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: adc_subtr_4_1
proc create_hier_cell_adc_subtr_4_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_adc_subtr_4_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_32

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I busy_0
  create_bd_pin -dir I calibn
  create_bd_pin -dir O cnv_0
  create_bd_pin -dir O -from 3 -to 0 detection
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -type rst s00_axi_aresetn
  create_bd_pin -dir O sample_donen
  create_bd_pin -dir O -type clk scki_0
  create_bd_pin -dir O sdi_0
  create_bd_pin -dir I -from 11 -to 0 sdi_config
  create_bd_pin -dir I -from 3 -to 0 sdo_0
  create_bd_pin -dir I startn
  create_bd_pin -dir O startn_subtr
  create_bd_pin -dir O subtr_donen

  # Create instance: axi_bram_ctrl_0_bram0, and set properties
  set axi_bram_ctrl_0_bram0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram0

  # Create instance: axi_bram_ctrl_0_bram1, and set properties
  set axi_bram_ctrl_0_bram1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram1 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram1

  # Create instance: axi_bram_ctrl_0_bram2, and set properties
  set axi_bram_ctrl_0_bram2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram2 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram2

  # Create instance: axi_bram_ctrl_0_bram3, and set properties
  set axi_bram_ctrl_0_bram3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram3 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram3

  # Create instance: ltc234416_0, and set properties
  set ltc234416_0 [ create_bd_cell -type ip -vlnv user.org:user:ltc234416:1.0 ltc234416_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.cnv_clk_cycles {5} \
   CONFIG.debug {false} \
   CONFIG.subtr_offset {400} \
 ] $ltc234416_0

  # Create instance: subtract_block_0, and set properties
  set subtract_block_0 [ create_bd_cell -type ip -vlnv user.org:user:subtract_block:1.0 subtract_block_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.debug {false} \
   CONFIG.subtr_offset {400} \
 ] $subtract_block_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins subtract_block_0/S00_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins BRAM_32] [get_bd_intf_pins ltc234416_0/BRAM_32]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM0]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM1]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM2]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM3]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM0]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM1]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM2]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM3]

  # Create port connections
  connect_bd_net -net busy_0_1 [get_bd_pins busy_0] [get_bd_pins ltc234416_0/busy]
  connect_bd_net -net calibn_1 [get_bd_pins calibn] [get_bd_pins ltc234416_0/calibn]
  connect_bd_net -net ltc234416_0_cnv [get_bd_pins cnv_0] [get_bd_pins ltc234416_0/cnv]
  connect_bd_net -net ltc234416_0_sample_donen [get_bd_pins sample_donen] [get_bd_pins ltc234416_0/sample_donen]
  connect_bd_net -net ltc234416_0_scki [get_bd_pins scki_0] [get_bd_pins ltc234416_0/scki]
  connect_bd_net -net ltc234416_0_sdi [get_bd_pins sdi_0] [get_bd_pins ltc234416_0/sdi]
  connect_bd_net -net ltc234416_0_startn_subtr [get_bd_pins startn_subtr] [get_bd_pins ltc234416_0/startn_subtr] [get_bd_pins subtract_block_0/startn]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins s00_axi_aclk] [get_bd_pins ltc234416_0/clk] [get_bd_pins subtract_block_0/s00_axi_aclk]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins s00_axi_aresetn] [get_bd_pins ltc234416_0/resetn] [get_bd_pins subtract_block_0/s00_axi_aresetn]
  connect_bd_net -net sdi_config_1 [get_bd_pins sdi_config] [get_bd_pins ltc234416_0/sdi_config]
  connect_bd_net -net sdo_0_1 [get_bd_pins sdo_0] [get_bd_pins ltc234416_0/sdo]
  connect_bd_net -net startn_1 [get_bd_pins startn] [get_bd_pins ltc234416_0/startn]
  connect_bd_net -net subtract_block_0_detection [get_bd_pins detection] [get_bd_pins subtract_block_0/detection]
  connect_bd_net -net subtract_block_0_subtr_donen [get_bd_pins subtr_donen] [get_bd_pins subtract_block_0/subtr_donen]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: adc_subtr_4_0
proc create_hier_cell_adc_subtr_4_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_adc_subtr_4_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_32

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I busy_0
  create_bd_pin -dir I calibn
  create_bd_pin -dir O cnv_0
  create_bd_pin -dir O -from 3 -to 0 detection
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -type rst s00_axi_aresetn
  create_bd_pin -dir O sample_donen
  create_bd_pin -dir O -type clk scki_0
  create_bd_pin -dir O sdi_0
  create_bd_pin -dir I -from 11 -to 0 sdi_config
  create_bd_pin -dir I -from 3 -to 0 sdo_0
  create_bd_pin -dir I startn
  create_bd_pin -dir O startn_subtr
  create_bd_pin -dir O subtr_donen

  # Create instance: axi_bram_ctrl_0_bram0, and set properties
  set axi_bram_ctrl_0_bram0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram0

  # Create instance: axi_bram_ctrl_0_bram1, and set properties
  set axi_bram_ctrl_0_bram1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram1 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram1

  # Create instance: axi_bram_ctrl_0_bram2, and set properties
  set axi_bram_ctrl_0_bram2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram2 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram2

  # Create instance: axi_bram_ctrl_0_bram3, and set properties
  set axi_bram_ctrl_0_bram3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram3 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {8} \
   CONFIG.Coe_File {no_coe_file_loaded} \
   CONFIG.EN_SAFETY_CKT {true} \
   CONFIG.Enable_32bit_Address {true} \
   CONFIG.Fill_Remaining_Memory_Locations {false} \
   CONFIG.Load_Init_File {false} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {WRITE_FIRST} \
   CONFIG.Operating_Mode_B {WRITE_FIRST} \
   CONFIG.Read_Width_A {32} \
   CONFIG.Read_Width_B {32} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Remaining_Memory_Locations {0} \
   CONFIG.Use_Byte_Write_Enable {true} \
   CONFIG.Use_RSTA_Pin {true} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.Write_Width_A {32} \
   CONFIG.Write_Width_B {32} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $axi_bram_ctrl_0_bram3

  # Create instance: ltc234416_0, and set properties
  set ltc234416_0 [ create_bd_cell -type ip -vlnv user.org:user:ltc234416:1.0 ltc234416_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.cnv_clk_cycles {5} \
   CONFIG.debug {false} \
   CONFIG.subtr_offset {400} \
 ] $ltc234416_0

  # Create instance: subtract_block_0, and set properties
  set subtract_block_0 [ create_bd_cell -type ip -vlnv user.org:user:subtract_block:1.0 subtract_block_0 ]
  set_property -dict [ list \
   CONFIG.BRAM_address_shift {2} \
   CONFIG.BRAM_address_size {13} \
   CONFIG.debug {false} \
   CONFIG.subtr_offset {400} \
 ] $subtract_block_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins subtract_block_0/S00_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins BRAM_32] [get_bd_intf_pins ltc234416_0/BRAM_32]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM0]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM1]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM2]
  connect_bd_intf_net -intf_net ltc234416_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTB] [get_bd_intf_pins ltc234416_0/BRAM3]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM0 [get_bd_intf_pins axi_bram_ctrl_0_bram0/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM0]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM1 [get_bd_intf_pins axi_bram_ctrl_0_bram1/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM1]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM2 [get_bd_intf_pins axi_bram_ctrl_0_bram2/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM2]
  connect_bd_intf_net -intf_net subtract_block_0_BRAM3 [get_bd_intf_pins axi_bram_ctrl_0_bram3/BRAM_PORTA] [get_bd_intf_pins subtract_block_0/BRAM3]

  # Create port connections
  connect_bd_net -net busy_0_1 [get_bd_pins busy_0] [get_bd_pins ltc234416_0/busy]
  connect_bd_net -net calibn_1 [get_bd_pins calibn] [get_bd_pins ltc234416_0/calibn]
  connect_bd_net -net ltc234416_0_cnv [get_bd_pins cnv_0] [get_bd_pins ltc234416_0/cnv]
  connect_bd_net -net ltc234416_0_sample_donen [get_bd_pins sample_donen] [get_bd_pins ltc234416_0/sample_donen]
  connect_bd_net -net ltc234416_0_scki [get_bd_pins scki_0] [get_bd_pins ltc234416_0/scki]
  connect_bd_net -net ltc234416_0_sdi [get_bd_pins sdi_0] [get_bd_pins ltc234416_0/sdi]
  connect_bd_net -net ltc234416_0_startn_subtr [get_bd_pins startn_subtr] [get_bd_pins ltc234416_0/startn_subtr] [get_bd_pins subtract_block_0/startn]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets ltc234416_0_startn_subtr]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins s00_axi_aclk] [get_bd_pins ltc234416_0/clk] [get_bd_pins subtract_block_0/s00_axi_aclk]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins s00_axi_aresetn] [get_bd_pins ltc234416_0/resetn] [get_bd_pins subtract_block_0/s00_axi_aresetn]
  connect_bd_net -net sdi_config_1 [get_bd_pins sdi_config] [get_bd_pins ltc234416_0/sdi_config]
  connect_bd_net -net sdo_0_1 [get_bd_pins sdo_0] [get_bd_pins ltc234416_0/sdo]
  connect_bd_net -net startn_1 [get_bd_pins startn] [get_bd_pins ltc234416_0/startn]
  connect_bd_net -net subtract_block_0_detection [get_bd_pins detection] [get_bd_pins subtract_block_0/detection]
  connect_bd_net -net subtract_block_0_subtr_donen [get_bd_pins subtr_donen] [get_bd_pins subtract_block_0/subtr_donen]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]

  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  set leds_8bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 leds_8bits ]


  # Create ports
  set TX_ON [ create_bd_port -dir I TX_ON ]
  set TX_ON1 [ create_bd_port -dir I TX_ON1 ]
  set busy_0 [ create_bd_port -dir I busy_0 ]
  set busy_1 [ create_bd_port -dir I busy_1 ]
  set busy_2 [ create_bd_port -dir I busy_2 ]
  set busy_3 [ create_bd_port -dir I busy_3 ]
  set busy_debug [ create_bd_port -dir O busy_debug ]
  set clkser_p [ create_bd_port -dir O -type clk clkser_p ]
  set clksys_p [ create_bd_port -dir O -type clk clksys_p ]
  set cnv_0 [ create_bd_port -dir O cnv_0 ]
  set cnv_1 [ create_bd_port -dir O cnv_1 ]
  set cnv_2 [ create_bd_port -dir O cnv_2 ]
  set cnv_3 [ create_bd_port -dir O cnv_3 ]
  set cnv_debug [ create_bd_port -dir O cnv_debug ]
  set cs_0 [ create_bd_port -dir O -from 0 -to 0 cs_0 ]
  set cs_1 [ create_bd_port -dir O -from 0 -to 0 cs_1 ]
  set cs_2 [ create_bd_port -dir O -from 0 -to 0 cs_2 ]
  set cs_3 [ create_bd_port -dir O -from 0 -to 0 cs_3 ]
  set data_in_p [ create_bd_port -dir O -from 3 -to 0 data_in_p ]
  set data_out [ create_bd_port -dir I data_out ]
  set enser_p [ create_bd_port -dir O enser_p ]
  set interrupt2 [ create_bd_port -dir I interrupt2 ]
  set scki_0 [ create_bd_port -dir O scki_0 ]
  set scki_1 [ create_bd_port -dir O -type clk scki_1 ]
  set scki_2 [ create_bd_port -dir O -type clk scki_2 ]
  set scki_3 [ create_bd_port -dir O -type clk scki_3 ]
  set scki_debug [ create_bd_port -dir O scki_debug ]
  set sdi_0 [ create_bd_port -dir O sdi_0 ]
  set sdi_1 [ create_bd_port -dir O sdi_1 ]
  set sdi_2 [ create_bd_port -dir O sdi_2 ]
  set sdi_3 [ create_bd_port -dir O sdi_3 ]
  set sdi_debug [ create_bd_port -dir O sdi_debug ]
  set sdo3_0_debug [ create_bd_port -dir O -from 0 -to 0 -type data sdo3_0_debug ]
  set sdo3_1_debug [ create_bd_port -dir O -from 0 -to 0 -type data sdo3_1_debug ]
  set sdo_0 [ create_bd_port -dir I -from 3 -to 0 sdo_0 ]
  set sdo_1 [ create_bd_port -dir I -from 3 -to 0 sdo_1 ]
  set sdo_2 [ create_bd_port -dir I -from 3 -to 0 sdo_2 ]
  set sdo_3 [ create_bd_port -dir I -from 3 -to 0 sdo_3 ]
  set trigger_p [ create_bd_port -dir O trigger_p ]

  # Create instance: STHV1600_0, and set properties
  set STHV1600_0 [ create_bd_cell -type ip -vlnv user.org:user:STHV1600:2.0 STHV1600_0 ]
  set_property -dict [ list \
   CONFIG.standalone {true} \
 ] $STHV1600_0

  # Create instance: STHV1600_0_bram, and set properties
  set STHV1600_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 STHV1600_0_bram ]
  set_property -dict [ list \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $STHV1600_0_bram

  # Create instance: adc_subtr_4_0
  create_hier_cell_adc_subtr_4_0 [current_bd_instance .] adc_subtr_4_0

  # Create instance: adc_subtr_4_1
  create_hier_cell_adc_subtr_4_1 [current_bd_instance .] adc_subtr_4_1

  # Create instance: adc_subtr_4_2
  create_hier_cell_adc_subtr_4_2 [current_bd_instance .] adc_subtr_4_2

  # Create instance: adc_subtr_4_3
  create_hier_cell_adc_subtr_4_3 [current_bd_instance .] adc_subtr_4_3

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_DOUT_DEFAULT {0x000000AA} \
   CONFIG.C_GPIO_WIDTH {8} \
   CONFIG.GPIO_BOARD_INTERFACE {leds_8bits} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_0

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]
  set_property -dict [ list \
   CONFIG.C_IRQ_IS_LEVEL {1} \
   CONFIG.Sense_of_IRQ_Edge_Type {Rising} \
   CONFIG.Sense_of_IRQ_Level_Type {Active_High} \
 ] $axi_intc_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {16} \
 ] $axi_interconnect_0

  # Create instance: hier_test_bram
  create_hier_cell_hier_test_bram [current_bd_instance .] hier_test_bram

  # Create instance: hier_test_bram1
  create_hier_cell_hier_test_bram1 [current_bd_instance .] hier_test_bram1

  # Create instance: hier_test_bram2
  create_hier_cell_hier_test_bram2 [current_bd_instance .] hier_test_bram2

  # Create instance: hier_test_bram3
  create_hier_cell_hier_test_bram3 [current_bd_instance .] hier_test_bram3

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
   CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
   CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
   CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
   CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {20.000000} \
   CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {666.666667} \
   CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ {100} \
   CONFIG.PCW_CLK0_FREQ {20000000} \
   CONFIG.PCW_CLK1_FREQ {10000000} \
   CONFIG.PCW_CLK2_FREQ {10000000} \
   CONFIG.PCW_CLK3_FREQ {10000000} \
   CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
   CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
   CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
   CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
   CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DDR_RAM_HIGHADDR {0x1FFFFFFF} \
   CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
   CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
   CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
   CONFIG.PCW_ENET0_RESET_ENABLE {0} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET1_RESET_ENABLE {0} \
   CONFIG.PCW_ENET_RESET_ENABLE {1} \
   CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_EN_CLK1_PORT {0} \
   CONFIG.PCW_EN_EMIO_TTC0 {1} \
   CONFIG.PCW_EN_ENET0 {1} \
   CONFIG.PCW_EN_GPIO {1} \
   CONFIG.PCW_EN_QSPI {1} \
   CONFIG.PCW_EN_SDIO0 {1} \
   CONFIG.PCW_EN_TTC0 {1} \
   CONFIG.PCW_EN_UART1 {1} \
   CONFIG.PCW_EN_USB0 {1} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {10} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {5} \
   CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK_CLK1_BUF {FALSE} \
   CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {20} \
   CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK1_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK2_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK3_ENABLE {0} \
   CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
   CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
   CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_I2C0_RESET_ENABLE {0} \
   CONFIG.PCW_I2C1_RESET_ENABLE {0} \
   CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
   CONFIG.PCW_I2C_RESET_ENABLE {1} \
   CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
   CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
   CONFIG.PCW_IRQ_F2P_INTR {1} \
   CONFIG.PCW_MIO_0_DIRECTION {inout} \
   CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_0_PULLUP {disabled} \
   CONFIG.PCW_MIO_0_SLEW {slow} \
   CONFIG.PCW_MIO_10_DIRECTION {inout} \
   CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_10_PULLUP {disabled} \
   CONFIG.PCW_MIO_10_SLEW {slow} \
   CONFIG.PCW_MIO_11_DIRECTION {inout} \
   CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_11_PULLUP {disabled} \
   CONFIG.PCW_MIO_11_SLEW {slow} \
   CONFIG.PCW_MIO_12_DIRECTION {inout} \
   CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_12_PULLUP {disabled} \
   CONFIG.PCW_MIO_12_SLEW {slow} \
   CONFIG.PCW_MIO_13_DIRECTION {inout} \
   CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_13_PULLUP {disabled} \
   CONFIG.PCW_MIO_13_SLEW {slow} \
   CONFIG.PCW_MIO_14_DIRECTION {inout} \
   CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_14_PULLUP {disabled} \
   CONFIG.PCW_MIO_14_SLEW {slow} \
   CONFIG.PCW_MIO_15_DIRECTION {inout} \
   CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_15_PULLUP {disabled} \
   CONFIG.PCW_MIO_15_SLEW {slow} \
   CONFIG.PCW_MIO_16_DIRECTION {out} \
   CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_16_PULLUP {disabled} \
   CONFIG.PCW_MIO_16_SLEW {fast} \
   CONFIG.PCW_MIO_17_DIRECTION {out} \
   CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_17_PULLUP {disabled} \
   CONFIG.PCW_MIO_17_SLEW {fast} \
   CONFIG.PCW_MIO_18_DIRECTION {out} \
   CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_18_PULLUP {disabled} \
   CONFIG.PCW_MIO_18_SLEW {fast} \
   CONFIG.PCW_MIO_19_DIRECTION {out} \
   CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_19_PULLUP {disabled} \
   CONFIG.PCW_MIO_19_SLEW {fast} \
   CONFIG.PCW_MIO_1_DIRECTION {out} \
   CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_1_PULLUP {disabled} \
   CONFIG.PCW_MIO_1_SLEW {fast} \
   CONFIG.PCW_MIO_20_DIRECTION {out} \
   CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_20_PULLUP {disabled} \
   CONFIG.PCW_MIO_20_SLEW {fast} \
   CONFIG.PCW_MIO_21_DIRECTION {out} \
   CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_21_PULLUP {disabled} \
   CONFIG.PCW_MIO_21_SLEW {fast} \
   CONFIG.PCW_MIO_22_DIRECTION {in} \
   CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_22_PULLUP {disabled} \
   CONFIG.PCW_MIO_22_SLEW {fast} \
   CONFIG.PCW_MIO_23_DIRECTION {in} \
   CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_23_PULLUP {disabled} \
   CONFIG.PCW_MIO_23_SLEW {fast} \
   CONFIG.PCW_MIO_24_DIRECTION {in} \
   CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_24_PULLUP {disabled} \
   CONFIG.PCW_MIO_24_SLEW {fast} \
   CONFIG.PCW_MIO_25_DIRECTION {in} \
   CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_25_PULLUP {disabled} \
   CONFIG.PCW_MIO_25_SLEW {fast} \
   CONFIG.PCW_MIO_26_DIRECTION {in} \
   CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_26_PULLUP {disabled} \
   CONFIG.PCW_MIO_26_SLEW {fast} \
   CONFIG.PCW_MIO_27_DIRECTION {in} \
   CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_27_PULLUP {disabled} \
   CONFIG.PCW_MIO_27_SLEW {fast} \
   CONFIG.PCW_MIO_28_DIRECTION {inout} \
   CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_28_PULLUP {disabled} \
   CONFIG.PCW_MIO_28_SLEW {fast} \
   CONFIG.PCW_MIO_29_DIRECTION {in} \
   CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_29_PULLUP {disabled} \
   CONFIG.PCW_MIO_29_SLEW {fast} \
   CONFIG.PCW_MIO_2_DIRECTION {inout} \
   CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_2_PULLUP {disabled} \
   CONFIG.PCW_MIO_2_SLEW {fast} \
   CONFIG.PCW_MIO_30_DIRECTION {out} \
   CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_30_PULLUP {disabled} \
   CONFIG.PCW_MIO_30_SLEW {fast} \
   CONFIG.PCW_MIO_31_DIRECTION {in} \
   CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_31_PULLUP {disabled} \
   CONFIG.PCW_MIO_31_SLEW {fast} \
   CONFIG.PCW_MIO_32_DIRECTION {inout} \
   CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_32_PULLUP {disabled} \
   CONFIG.PCW_MIO_32_SLEW {fast} \
   CONFIG.PCW_MIO_33_DIRECTION {inout} \
   CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_33_PULLUP {disabled} \
   CONFIG.PCW_MIO_33_SLEW {fast} \
   CONFIG.PCW_MIO_34_DIRECTION {inout} \
   CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_34_PULLUP {disabled} \
   CONFIG.PCW_MIO_34_SLEW {fast} \
   CONFIG.PCW_MIO_35_DIRECTION {inout} \
   CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_35_PULLUP {disabled} \
   CONFIG.PCW_MIO_35_SLEW {fast} \
   CONFIG.PCW_MIO_36_DIRECTION {in} \
   CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_36_PULLUP {disabled} \
   CONFIG.PCW_MIO_36_SLEW {fast} \
   CONFIG.PCW_MIO_37_DIRECTION {inout} \
   CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_37_PULLUP {disabled} \
   CONFIG.PCW_MIO_37_SLEW {fast} \
   CONFIG.PCW_MIO_38_DIRECTION {inout} \
   CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_38_PULLUP {disabled} \
   CONFIG.PCW_MIO_38_SLEW {fast} \
   CONFIG.PCW_MIO_39_DIRECTION {inout} \
   CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_39_PULLUP {disabled} \
   CONFIG.PCW_MIO_39_SLEW {fast} \
   CONFIG.PCW_MIO_3_DIRECTION {inout} \
   CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_3_PULLUP {disabled} \
   CONFIG.PCW_MIO_3_SLEW {fast} \
   CONFIG.PCW_MIO_40_DIRECTION {inout} \
   CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_40_PULLUP {disabled} \
   CONFIG.PCW_MIO_40_SLEW {fast} \
   CONFIG.PCW_MIO_41_DIRECTION {inout} \
   CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_41_PULLUP {disabled} \
   CONFIG.PCW_MIO_41_SLEW {fast} \
   CONFIG.PCW_MIO_42_DIRECTION {inout} \
   CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_42_PULLUP {disabled} \
   CONFIG.PCW_MIO_42_SLEW {fast} \
   CONFIG.PCW_MIO_43_DIRECTION {inout} \
   CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_43_PULLUP {disabled} \
   CONFIG.PCW_MIO_43_SLEW {fast} \
   CONFIG.PCW_MIO_44_DIRECTION {inout} \
   CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_44_PULLUP {disabled} \
   CONFIG.PCW_MIO_44_SLEW {fast} \
   CONFIG.PCW_MIO_45_DIRECTION {inout} \
   CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_45_PULLUP {disabled} \
   CONFIG.PCW_MIO_45_SLEW {fast} \
   CONFIG.PCW_MIO_46_DIRECTION {in} \
   CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_46_PULLUP {disabled} \
   CONFIG.PCW_MIO_46_SLEW {slow} \
   CONFIG.PCW_MIO_47_DIRECTION {in} \
   CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_47_PULLUP {disabled} \
   CONFIG.PCW_MIO_47_SLEW {slow} \
   CONFIG.PCW_MIO_48_DIRECTION {out} \
   CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_48_PULLUP {disabled} \
   CONFIG.PCW_MIO_48_SLEW {slow} \
   CONFIG.PCW_MIO_49_DIRECTION {in} \
   CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_49_PULLUP {disabled} \
   CONFIG.PCW_MIO_49_SLEW {slow} \
   CONFIG.PCW_MIO_4_DIRECTION {inout} \
   CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_4_PULLUP {disabled} \
   CONFIG.PCW_MIO_4_SLEW {fast} \
   CONFIG.PCW_MIO_50_DIRECTION {inout} \
   CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_50_PULLUP {disabled} \
   CONFIG.PCW_MIO_50_SLEW {slow} \
   CONFIG.PCW_MIO_51_DIRECTION {inout} \
   CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_51_PULLUP {disabled} \
   CONFIG.PCW_MIO_51_SLEW {slow} \
   CONFIG.PCW_MIO_52_DIRECTION {out} \
   CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_52_PULLUP {disabled} \
   CONFIG.PCW_MIO_52_SLEW {slow} \
   CONFIG.PCW_MIO_53_DIRECTION {inout} \
   CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_53_PULLUP {disabled} \
   CONFIG.PCW_MIO_53_SLEW {slow} \
   CONFIG.PCW_MIO_5_DIRECTION {inout} \
   CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_5_PULLUP {disabled} \
   CONFIG.PCW_MIO_5_SLEW {fast} \
   CONFIG.PCW_MIO_6_DIRECTION {out} \
   CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_6_PULLUP {disabled} \
   CONFIG.PCW_MIO_6_SLEW {fast} \
   CONFIG.PCW_MIO_7_DIRECTION {out} \
   CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_7_PULLUP {disabled} \
   CONFIG.PCW_MIO_7_SLEW {slow} \
   CONFIG.PCW_MIO_8_DIRECTION {out} \
   CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_8_PULLUP {disabled} \
   CONFIG.PCW_MIO_8_SLEW {fast} \
   CONFIG.PCW_MIO_9_DIRECTION {inout} \
   CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_9_PULLUP {disabled} \
   CONFIG.PCW_MIO_9_SLEW {slow} \
   CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#UART 1#UART 1#GPIO#GPIO#Enet 0#Enet 0} \
   CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#gpio[7]#gpio[8]#gpio[9]#gpio[10]#gpio[11]#gpio[12]#gpio[13]#gpio[14]#gpio[15]#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#wp#cd#tx#rx#gpio[50]#gpio[51]#mdc#mdio} \
   CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
   CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
   CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
   CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
   CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
   CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
   CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
   CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
   CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
   CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_WP_IO {MIO 46} \
   CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
   CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
   CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
   CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
   CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
   CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
   CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
   CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
   CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
   CONFIG.PCW_UIPARAM_DDR_BL {8} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.41} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.411} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.341} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.358} \
   CONFIG.PCW_UIPARAM_DDR_CL {7} \
   CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
   CONFIG.PCW_UIPARAM_DDR_CWL {6} \
   CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {2048 MBits} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.025} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.028} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.001} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.001} \
   CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
   CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333313} \
   CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
   CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J128M16 HA-15E} \
   CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {14} \
   CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
   CONFIG.PCW_UIPARAM_DDR_T_FAW {45.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {36.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RC {49.5} \
   CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
   CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
   CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
   CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
   CONFIG.PCW_USB0_RESET_ENABLE {0} \
   CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
   CONFIG.PCW_USB1_RESET_ENABLE {0} \
   CONFIG.PCW_USB_RESET_ENABLE {1} \
   CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
   CONFIG.preset {ZedBoard} \
 ] $processing_system7_0

  # Create instance: rst_ps7_0_100M, and set properties
  set rst_ps7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_100M ]

  # Create instance: silense_FSM_0, and set properties
  set silense_FSM_0 [ create_bd_cell -type ip -vlnv user.org:user:silense_FSM:1.0 silense_FSM_0 ]

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {42} \
   CONFIG.C_DATA_DEPTH {16384} \
   CONFIG.C_MON_TYPE {MIX} \
   CONFIG.C_NUM_MONITOR_SLOTS {1} \
   CONFIG.C_NUM_OF_PROBES {10} \
   CONFIG.C_PROBE0_TYPE {0} \
   CONFIG.C_PROBE10_TYPE {0} \
   CONFIG.C_PROBE11_TYPE {0} \
   CONFIG.C_PROBE12_TYPE {0} \
   CONFIG.C_PROBE13_TYPE {0} \
   CONFIG.C_PROBE14_TYPE {0} \
   CONFIG.C_PROBE15_TYPE {0} \
   CONFIG.C_PROBE16_TYPE {0} \
   CONFIG.C_PROBE17_TYPE {0} \
   CONFIG.C_PROBE18_TYPE {0} \
   CONFIG.C_PROBE19_TYPE {0} \
   CONFIG.C_PROBE1_TYPE {0} \
   CONFIG.C_PROBE20_TYPE {0} \
   CONFIG.C_PROBE21_TYPE {0} \
   CONFIG.C_PROBE22_TYPE {0} \
   CONFIG.C_PROBE2_TYPE {0} \
   CONFIG.C_PROBE3_TYPE {0} \
   CONFIG.C_PROBE4_TYPE {0} \
   CONFIG.C_PROBE5_TYPE {0} \
   CONFIG.C_PROBE6_TYPE {0} \
   CONFIG.C_PROBE7_TYPE {0} \
   CONFIG.C_PROBE8_TYPE {0} \
   CONFIG.C_PROBE9_TYPE {0} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:bram_rtl:1.0} \
   CONFIG.C_SLOT_0_TYPE {0} \
   CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:bram_rtl:1.0} \
   CONFIG.C_SLOT_1_TYPE {0} \
   CONFIG.C_SLOT_2_INTF_TYPE {xilinx.com:interface:bram_rtl:1.0} \
   CONFIG.C_SLOT_2_TYPE {0} \
   CONFIG.C_SLOT_3_INTF_TYPE {xilinx.com:interface:bram_rtl:1.0} \
   CONFIG.C_SLOT_3_TYPE {0} \
 ] $system_ila_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat_0

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_1

  # Create instance: xlconcat_2, and set properties
  set xlconcat_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_2 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_2

  # Create instance: xlconcat_3, and set properties
  set xlconcat_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_3 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {4} \
   CONFIG.IN1_WIDTH {4} \
   CONFIG.IN2_WIDTH {4} \
   CONFIG.IN3_WIDTH {4} \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_3

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_WIDTH {4} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create interface connections
  connect_bd_intf_net -intf_net BRAM_PORTB_1 [get_bd_intf_pins adc_subtr_4_1/BRAM_32] [get_bd_intf_pins hier_test_bram1/BRAM_PORTB]
connect_bd_intf_net -intf_net Conn [get_bd_intf_pins adc_subtr_4_3/BRAM0] [get_bd_intf_pins system_ila_0/SLOT_0_BRAM]
  connect_bd_intf_net -intf_net STHV1600_0_read_data_BRAM [get_bd_intf_pins STHV1600_0/read_data_BRAM] [get_bd_intf_pins STHV1600_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net adc_subtr_4_0_BRAM_32 [get_bd_intf_pins adc_subtr_4_0/BRAM_32] [get_bd_intf_pins hier_test_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net adc_subtr_4_2_BRAM_32 [get_bd_intf_pins adc_subtr_4_2/BRAM_32] [get_bd_intf_pins hier_test_bram2/BRAM_PORTB]
  connect_bd_intf_net -intf_net adc_subtr_4_3_BRAM_32 [get_bd_intf_pins adc_subtr_4_3/BRAM_32] [get_bd_intf_pins hier_test_bram3/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins STHV1600_0_bram/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports leds_8bits] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins hier_test_bram/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins silense_FSM_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins silense_FSM_0/S_AXI_INTR]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins adc_subtr_4_0/S00_AXI] [get_bd_intf_pins axi_interconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M05_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins axi_interconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M06_AXI [get_bd_intf_pins adc_subtr_4_1/S00_AXI] [get_bd_intf_pins axi_interconnect_0/M06_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M07_AXI [get_bd_intf_pins adc_subtr_4_2/S00_AXI] [get_bd_intf_pins axi_interconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M08_AXI [get_bd_intf_pins adc_subtr_4_3/S00_AXI] [get_bd_intf_pins axi_interconnect_0/M08_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M09_AXI [get_bd_intf_pins axi_interconnect_0/M09_AXI] [get_bd_intf_pins hier_test_bram1/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M10_AXI [get_bd_intf_pins axi_interconnect_0/M10_AXI] [get_bd_intf_pins hier_test_bram2/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M11_AXI [get_bd_intf_pins axi_interconnect_0/M11_AXI] [get_bd_intf_pins hier_test_bram3/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M12_AXI [get_bd_intf_pins STHV1600_0/S00_AXI_PRG] [get_bd_intf_pins axi_interconnect_0/M12_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M13_AXI [get_bd_intf_pins STHV1600_0/S01_AXI_TRIG] [get_bd_intf_pins axi_interconnect_0/M13_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M14_AXI [get_bd_intf_pins STHV1600_0/S_AXI_INTR] [get_bd_intf_pins axi_interconnect_0/M14_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M15_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M15_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net STHV1600_0_data_inp [get_bd_ports data_in_p] [get_bd_pins STHV1600_0/data_inp] [get_bd_pins system_ila_0/probe7]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets STHV1600_0_data_inp]
  connect_bd_net -net STHV1600_0_enserp [get_bd_ports enser_p] [get_bd_pins STHV1600_0/enserp] [get_bd_pins system_ila_0/probe8]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets STHV1600_0_enserp]
  connect_bd_net -net STHV1600_0_irq [get_bd_pins STHV1600_0/irq] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net STHV1600_0_trigger [get_bd_ports trigger_p] [get_bd_pins STHV1600_0/trigger]
  connect_bd_net -net TX_ON1_1 [get_bd_ports TX_ON1] [get_bd_pins STHV1600_0/TX_ON] [get_bd_pins system_ila_0/probe5]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets TX_ON1_1]
  connect_bd_net -net TX_ON_1 [get_bd_ports TX_ON] [get_bd_pins silense_FSM_0/TX_ON] [get_bd_pins system_ila_0/probe2]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets TX_ON_1]
  connect_bd_net -net adc_subtr_4_0_sample_donen [get_bd_pins adc_subtr_4_0/sample_donen] [get_bd_pins xlconcat_2/In0]
  connect_bd_net -net adc_subtr_4_0_scki_0 [get_bd_ports scki_0] [get_bd_pins adc_subtr_4_0/scki_0]
  connect_bd_net -net adc_subtr_4_0_subtr_donen [get_bd_pins adc_subtr_4_0/subtr_donen] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net adc_subtr_4_1_cnv_0 [get_bd_ports cnv_1] [get_bd_pins adc_subtr_4_1/cnv_0]
  connect_bd_net -net adc_subtr_4_1_detection [get_bd_pins adc_subtr_4_1/detection] [get_bd_pins xlconcat_3/In1]
  connect_bd_net -net adc_subtr_4_1_sample_donen [get_bd_pins adc_subtr_4_1/sample_donen] [get_bd_pins xlconcat_2/In1]
  connect_bd_net -net adc_subtr_4_1_scki_0 [get_bd_ports scki_1] [get_bd_pins adc_subtr_4_1/scki_0]
  connect_bd_net -net adc_subtr_4_1_sdi_0 [get_bd_ports sdi_1] [get_bd_pins adc_subtr_4_1/sdi_0]
  connect_bd_net -net adc_subtr_4_1_subtr_donen [get_bd_pins adc_subtr_4_1/subtr_donen] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net adc_subtr_4_2_cnv_0 [get_bd_ports cnv_2] [get_bd_pins adc_subtr_4_2/cnv_0]
  connect_bd_net -net adc_subtr_4_2_detection [get_bd_pins adc_subtr_4_2/detection] [get_bd_pins xlconcat_3/In2]
  connect_bd_net -net adc_subtr_4_2_sample_donen [get_bd_pins adc_subtr_4_2/sample_donen] [get_bd_pins xlconcat_2/In2]
  connect_bd_net -net adc_subtr_4_2_scki_0 [get_bd_ports scki_2] [get_bd_pins adc_subtr_4_2/scki_0]
  connect_bd_net -net adc_subtr_4_2_sdi_0 [get_bd_ports sdi_2] [get_bd_pins adc_subtr_4_2/sdi_0]
  connect_bd_net -net adc_subtr_4_2_subtr_donen [get_bd_pins adc_subtr_4_2/subtr_donen] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net adc_subtr_4_3_cnv_0 [get_bd_ports cnv_3] [get_bd_ports cnv_debug] [get_bd_pins adc_subtr_4_3/cnv_0]
  connect_bd_net -net adc_subtr_4_3_detection [get_bd_pins adc_subtr_4_3/detection] [get_bd_pins system_ila_0/probe4] [get_bd_pins xlconcat_3/In3]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets adc_subtr_4_3_detection]
  connect_bd_net -net adc_subtr_4_3_sample_donen [get_bd_pins adc_subtr_4_3/sample_donen] [get_bd_pins xlconcat_2/In3]
  connect_bd_net -net adc_subtr_4_3_scki_0 [get_bd_ports scki_3] [get_bd_ports scki_debug] [get_bd_pins adc_subtr_4_3/scki_0]
  connect_bd_net -net adc_subtr_4_3_sdi_0 [get_bd_ports sdi_3] [get_bd_ports sdi_debug] [get_bd_pins adc_subtr_4_3/sdi_0]
  connect_bd_net -net adc_subtr_4_3_subtr_donen [get_bd_pins adc_subtr_4_3/subtr_donen] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net adc_subtr_4_cnv_0 [get_bd_ports cnv_0] [get_bd_pins adc_subtr_4_0/cnv_0]
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins processing_system7_0/IRQ_F2P]
  connect_bd_net -net busy_0_1 [get_bd_ports busy_0] [get_bd_pins adc_subtr_4_0/busy_0]
  connect_bd_net -net busy_0_2 [get_bd_ports busy_1] [get_bd_pins adc_subtr_4_1/busy_0]
  connect_bd_net -net busy_0_3 [get_bd_ports busy_2] [get_bd_pins adc_subtr_4_2/busy_0]
  connect_bd_net -net busy_0_4 [get_bd_ports busy_3] [get_bd_ports busy_debug] [get_bd_pins adc_subtr_4_3/busy_0]
  connect_bd_net -net data_out_1 [get_bd_ports data_out] [get_bd_pins STHV1600_0/data_out] [get_bd_pins system_ila_0/probe9]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets data_out_1]
  connect_bd_net -net interrupt2_1 [get_bd_ports interrupt2] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net ltc234416_0_sdi [get_bd_ports sdi_0] [get_bd_pins adc_subtr_4_0/sdi_0]
  connect_bd_net -net ltc234416_0_startn_subtr [get_bd_pins adc_subtr_4_0/startn_subtr] [get_bd_pins system_ila_0/probe0]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets ltc234416_0_startn_subtr]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_ports clkser_p] [get_bd_ports clksys_p] [get_bd_pins STHV1600_0/s00_axi_prg_aclk] [get_bd_pins STHV1600_0/s01_axi_trig_aclk] [get_bd_pins STHV1600_0/s_axi_intr_aclk] [get_bd_pins adc_subtr_4_0/s00_axi_aclk] [get_bd_pins adc_subtr_4_1/s00_axi_aclk] [get_bd_pins adc_subtr_4_2/s00_axi_aclk] [get_bd_pins adc_subtr_4_3/s00_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/M05_ACLK] [get_bd_pins axi_interconnect_0/M06_ACLK] [get_bd_pins axi_interconnect_0/M07_ACLK] [get_bd_pins axi_interconnect_0/M08_ACLK] [get_bd_pins axi_interconnect_0/M09_ACLK] [get_bd_pins axi_interconnect_0/M10_ACLK] [get_bd_pins axi_interconnect_0/M11_ACLK] [get_bd_pins axi_interconnect_0/M12_ACLK] [get_bd_pins axi_interconnect_0/M13_ACLK] [get_bd_pins axi_interconnect_0/M14_ACLK] [get_bd_pins axi_interconnect_0/M15_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins hier_test_bram/s_axi_aclk] [get_bd_pins hier_test_bram1/s_axi_aclk] [get_bd_pins hier_test_bram2/s_axi_aclk] [get_bd_pins hier_test_bram3/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins rst_ps7_0_100M/slowest_sync_clk] [get_bd_pins silense_FSM_0/s00_axi_aclk] [get_bd_pins silense_FSM_0/s_axi_intr_aclk] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_100M/ext_reset_in]
  connect_bd_net -net rst_ps7_0_100M_peripheral_aresetn [get_bd_pins STHV1600_0/s00_axi_prg_aresetn] [get_bd_pins STHV1600_0/s01_axi_trig_aresetn] [get_bd_pins STHV1600_0/s_axi_intr_aresetn] [get_bd_pins adc_subtr_4_0/s00_axi_aresetn] [get_bd_pins adc_subtr_4_1/s00_axi_aresetn] [get_bd_pins adc_subtr_4_2/s00_axi_aresetn] [get_bd_pins adc_subtr_4_3/s00_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/M05_ARESETN] [get_bd_pins axi_interconnect_0/M06_ARESETN] [get_bd_pins axi_interconnect_0/M07_ARESETN] [get_bd_pins axi_interconnect_0/M08_ARESETN] [get_bd_pins axi_interconnect_0/M09_ARESETN] [get_bd_pins axi_interconnect_0/M10_ARESETN] [get_bd_pins axi_interconnect_0/M11_ARESETN] [get_bd_pins axi_interconnect_0/M12_ARESETN] [get_bd_pins axi_interconnect_0/M13_ARESETN] [get_bd_pins axi_interconnect_0/M14_ARESETN] [get_bd_pins axi_interconnect_0/M15_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins hier_test_bram/s_axi_aresetn] [get_bd_pins hier_test_bram1/s_axi_aresetn] [get_bd_pins hier_test_bram2/s_axi_aresetn] [get_bd_pins hier_test_bram3/s_axi_aresetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn] [get_bd_pins silense_FSM_0/s00_axi_aresetn] [get_bd_pins silense_FSM_0/s_axi_intr_aresetn]
  connect_bd_net -net sdo_0_1 [get_bd_ports sdo_0] [get_bd_pins adc_subtr_4_0/sdo_0] [get_bd_pins system_ila_0/probe3]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets sdo_0_1]
  connect_bd_net -net sdo_0_2 [get_bd_ports sdo_1] [get_bd_pins adc_subtr_4_1/sdo_0]
  connect_bd_net -net sdo_0_3 [get_bd_ports sdo_2] [get_bd_pins adc_subtr_4_2/sdo_0]
  connect_bd_net -net sdo_0_4 [get_bd_ports sdo_3] [get_bd_pins adc_subtr_4_3/sdo_0] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net silense_FSM_0_calibn [get_bd_pins adc_subtr_4_0/calibn] [get_bd_pins adc_subtr_4_1/calibn] [get_bd_pins adc_subtr_4_2/calibn] [get_bd_pins adc_subtr_4_3/calibn] [get_bd_pins silense_FSM_0/calibn]
  connect_bd_net -net silense_FSM_0_irq [get_bd_pins axi_intc_0/intr] [get_bd_pins system_ila_0/probe1] [get_bd_pins xlconcat_0/dout]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets silense_FSM_0_irq]
  connect_bd_net -net silense_FSM_0_irq1 [get_bd_pins silense_FSM_0/irq] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net silense_FSM_0_sdi_config [get_bd_pins adc_subtr_4_0/sdi_config] [get_bd_pins adc_subtr_4_1/sdi_config] [get_bd_pins adc_subtr_4_2/sdi_config] [get_bd_pins adc_subtr_4_3/sdi_config] [get_bd_pins silense_FSM_0/sdi_config]
  connect_bd_net -net silense_FSM_0_startn_cap [get_bd_pins adc_subtr_4_0/startn] [get_bd_pins adc_subtr_4_1/startn] [get_bd_pins adc_subtr_4_2/startn] [get_bd_pins adc_subtr_4_3/startn] [get_bd_pins silense_FSM_0/startn_cap] [get_bd_pins system_ila_0/probe6]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets silense_FSM_0_startn_cap]
  connect_bd_net -net subtract_block_0_detection [get_bd_pins adc_subtr_4_0/detection] [get_bd_pins xlconcat_3/In0]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins silense_FSM_0/subtr_donen] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins silense_FSM_0/sample_donen] [get_bd_pins xlconcat_2/dout]
  connect_bd_net -net xlconcat_3_dout [get_bd_pins silense_FSM_0/detection] [get_bd_pins xlconcat_3/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_ports cs_0] [get_bd_ports cs_1] [get_bd_ports cs_2] [get_bd_ports cs_3] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_ports sdo3_0_debug] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_ports sdo3_1_debug] [get_bd_pins xlslice_1/Dout]

  # Create address segments
  assign_bd_address -offset 0x43C60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs STHV1600_0/S00_AXI_PRG/S00_AXI_PRG_reg] -force
  assign_bd_address -offset 0x43C70000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs STHV1600_0/S01_AXI_TRIG/S01_AXI_TRIG_reg] -force
  assign_bd_address -offset 0x43C80000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs STHV1600_0/S_AXI_INTR/reg0] -force
  assign_bd_address -offset 0x40000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs hier_test_bram/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x42000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs hier_test_bram1/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x44000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs hier_test_bram2/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x46000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs hier_test_bram3/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x48000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x41800000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x43C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs silense_FSM_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x43C10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs silense_FSM_0/S_AXI_INTR/S_AXI_INTR_reg] -force
  assign_bd_address -offset 0x43C20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs adc_subtr_4_0/subtract_block_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x43C30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs adc_subtr_4_1/subtract_block_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x43C40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs adc_subtr_4_2/subtract_block_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x43C50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs adc_subtr_4_3/subtract_block_0/S00_AXI/S00_AXI_reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



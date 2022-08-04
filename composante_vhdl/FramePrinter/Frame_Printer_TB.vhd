----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.08.2022 22:26:20
-- Design Name: 
-- Module Name: Frame_Printer_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Frame_Printer_TB is
--  Port ( );
end Frame_Printer_TB;

architecture Behavioral of Frame_Printer_TB is

component frame_printer is
    Port ( PositionX : in STD_LOGIC_VECTOR (8 downto 0);
           PositionY : in STD_LOGIC_VECTOR (8 downto 0);
           i_clk: in STD_LOGIC;
           i_rst: in STD_LOGIC;
           i_en: in STD_LOGIC;
           control : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin


end Behavioral;

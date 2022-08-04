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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Frame_Printer_TB is
--  Port ( );
end Frame_Printer_TB;

architecture Behavioral of Frame_Printer_TB is
signal   d_clk_p, d_reset       :  std_logic := '0';
 constant c_clk_p_Period      : time :=  30 ns;  -- 50 MHz 
 constant c_clk_16pixel      : time :=  480 ns;  -- 50 MHz 
 signal s_PositionX, s_PositionY :  STD_LOGIC_VECTOR (8 downto 0);
 signal s_control: std_logic_vector (3 downto 0):= "0000";
 signal s_enable, s_valid: std_logic;
 signal s_lastLine: std_logic ;
 signal s_user: std_logic;
 signal globalX              : integer := 0;
signal globalY              : integer := 0;
signal s_INcouleur: std_logic_vector( 31 downto 0);
signal s_OUTcouleur : std_logic_vector( 23 downto 0);
 
component testPatternGenerator is
   Port ( clk : in STD_LOGIC ;
           rstn : in std_logic;
           m_axis_tuser : out std_logic;
           m_axis_tlast : out std_logic;
           m_axis_tvalid : out std_logic;
           m_axis_tdata : out std_logic_vector(23 downto 0);
           m_axis_tready : in std_logic;
           i_colorDataA : in std_logic_vector(31 downto 0);
           i_scrollX  : in std_logic_vector (8 downto 0);
           i_scrollY  : in std_logic_vector (8 downto 0);
           o_globalX : out std_logic_vector (8 downto 0);
           o_globalY : out std_logic_vector (8 downto 0)
      --     i_colorDataB : in std_logic_vector(31 downto 0)
);
end component;

begin
inst_frame_printer: testPatternGenerator
port map(
 clk    => d_clk_p,
 rstn    => d_reset,
 m_axis_tuser  => s_user,
 m_axis_tlast  => s_lastLine,
 m_axis_tvalid => s_valid,
 m_axis_tdata  => s_OUTcouleur,
 m_axis_tready => s_enable,
 i_colorDataA  => s_INcouleur,
 i_scrollX    => "000000000",
 i_scrollY    => "000000000",
 o_globalX    => s_PositionX,
 o_globalY    => s_PositionY
 --i_colorDataB  => 
);
  sim_clk_p:  process
   begin
      d_clk_p <= '1';  -- init
      loop
         wait for c_clk_p_Period / 2;
         d_clk_p <= not d_clk_p; -- invert clock value
      end loop;
   end process;  

tb : PROCESS
   BEGIN
   d_reset <= '1';
   s_enable <= '1';
   s_INcouleur <=  x"00FFFFFF";
   
     wait for c_clk_16pixel; 
     s_INcouleur <=  x"00B5E61D";
     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
--     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     
     
     s_INcouleur <=  x"00FFF200";
     wait;
   end process;

--s_PositionX <= std_logic_vector(TO_UNSIGNED(globalX, s_PositionX'length ));
--s_PositionY <= std_logic_vector(TO_UNSIGNED(globalY, s_PositionY'length ));

--position: process
--begin
--loop
--    wait for c_clk_p_Period;
--    globalX <= (globalX+1) mod 260;
--    if(globalX = 255) then 
--        globalY <= (globalY+1) mod 230;
--    end if;
   
--end loop;

--end process;

end Behavioral;

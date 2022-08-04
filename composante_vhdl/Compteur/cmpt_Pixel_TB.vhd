----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.08.2022 20:26:10
-- Design Name: 
-- Module Name: cmpt_Pixel_TB - Behavioral
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

entity cmpt_Pixel_TB is
--  Port ( );
end cmpt_Pixel_TB;

architecture Behavioral of cmpt_Pixel_TB is
signal   d_clk_p, d_reset       :  std_logic := '0';
 constant c_clk_p_Period      : time :=  30 ns;  -- 50 MHz 
 constant c_clk_16pixel      : time :=  480 ns;
 signal s_PositionX, s_PositionY :  STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
 signal s_enable             : std_logic := '1';
 signal s_scrollX, s_ScrollY :  STD_LOGIC_VECTOR (8 downto 0) := (others => '0');

component compteur_pixel is
    Port ( i_reset : in STD_LOGIC;
           i_enable : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           i_scrollX  :in std_logic_vector(8 downto 0);
           i_scrollY  :in std_logic_vector(8 downto 0);
           o_PositionX : out STD_LOGIC_VECTOR (8 downto 0);
           o_PositionY : out STD_LOGIC_VECTOR (8 downto 0));
end component;

begin

uut: compteur_pixel
Port map( 
    i_reset  => d_reset,
    i_enable => s_enable,
    i_clk    => d_clk_p,
    i_scrollX   => s_scrollX,
    i_scrollY   => s_ScrollY,
    o_PositionX => s_PositionX,
    o_PositionY => s_PositionY
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
   wait for c_clk_p_Period;  
   d_reset <= '0';
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
--     wait for c_clk_16pixel;  
--     wait for c_clk_16pixel;  
--     wait for c_clk_16pixel;  
--     wait for c_clk_16pixel;  
--     s_scrollX <= "011111111";
--     s_ScrollY <= "000010000";
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
--     wait for c_clk_16pixel;  
--     wait for c_clk_16pixel;  
--     wait for c_clk_16pixel;  
--     wait for c_clk_16pixel; 
--     s_scrollX <= "000010000";
--     s_ScrollY <= "011011111";
     wait;
  end process;

end Behavioral;

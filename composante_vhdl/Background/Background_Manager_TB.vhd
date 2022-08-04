----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2022 10:46:55
-- Design Name: 
-- Module Name: Background_Manager_TB - Behavioral
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

entity Background_Manager_TB is
--  Port ( );
end Background_Manager_TB;

architecture Behavioral of Background_Manager_TB is
signal   d_clk_p, d_reset       :  std_logic := '0';
 constant c_clk_p_Period      : time :=  20 ns;  -- 50 MHz 
 constant c_clk_16pixel      : time :=  480 ns;  -- 50 MHz 
signal s_PositionX, s_PositionY :  STD_LOGIC_VECTOR (8 downto 0);
signal s_setTileId: STD_LOGIC_VECTOR (7 downto 0);
signal s_setTileX, s_setTileY : STD_LOGIC_VECTOR (8 downto 0);
signal s_colorCode: STD_ULOGIC_VECTOR (3 downto 0);
signal globalX, globalY : integer := 0;
signal s_setBg :  STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal s_bgTile_WE              : std_logic := '0';

component BackgroundManager is
    Port ( clk      : in std_ulogic;
           PositionX : in STD_LOGIC_VECTOR (8 downto 0);
           PositionY : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileX : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileY : in STD_LOGIC_VECTOR (8 downto 0);
           TuileId   : in STD_LOGIC_VECTOR (7 downto 0);
	   i_backgroundTile_XY_we  : in STD_LOGIC := '0';
 	  -- SetMap    : in  STD_LOGIC_VECTOR(3 downto 0);
           colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
end component;

begin
UUT: BackgroundManager
Port map(
clk        => d_clk_p,
PositionX  => s_PositionX,
PositionY  => s_PositionY,
SetTuileX  => s_setTileX,
SetTuileY  => s_setTileY,
TuileId    => s_setTileId,
i_backgroundTile_XY_we => s_bgTile_WE,
--SetMap     => s_setBg,
colorCode  => s_colorCode
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
      wait for c_clk_p_Period;  
     --wait for c_clk_16pixel;
        s_bgTile_WE <= '1';
     s_setTileX <= "000000000";
     s_setTileY <= "000000000";
     s_setTileId <= x"0a";
     wait for c_clk_p_Period; 
      s_bgTile_WE <= '0';
     wait for c_clk_16pixel;
    
     wait for c_clk_16pixel; 
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
      --s_setBg <= x"2" ;
      
     s_setTileX <= "000000000";
     s_setTileY <= "000010000";
     s_bgTile_WE <= '1';
     s_setTileId <= x"0c"; 
         wait for c_clk_p_Period; 
     s_setTileX <= "000010000";
     s_setTileY <= "000110000";
    -- s_bgTile_WE <= '1';
     s_setTileId <= x"0d"; 
     wait for c_clk_p_Period; 
     s_setTileX <= "000100000";
     s_setTileY <= "000010000";
    -- s_bgTile_WE <= '1';
     s_setTileId <= x"0e"; 
     wait for c_clk_p_Period;
     s_bgTile_WE <= '0';
wait for c_clk_16pixel;
wait for c_clk_16pixel; 
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
     wait for c_clk_16pixel;
      --s_setBg <= x"2" ;
      
     s_setTileX <= "000000000";
     s_setTileY <= "000000000";
     s_bgTile_WE <= '0';
     s_setTileId <= x"00"; 
--   end loop;
      WAIT; -- will wait forever
   END PROCESS;

s_PositionX <= std_logic_vector(TO_UNSIGNED(globalX, s_PositionX'length ));
s_PositionY <= std_logic_vector(TO_UNSIGNED(globalY, s_PositionY'length ));


position: process
begin
loop
    wait for c_clk_p_Period;
    globalX <= (globalX+1) mod 256;
    if(globalX = 255) then 
        globalY <= (globalY+1) mod 224;
    end if;
   
end loop;

end process;

end Behavioral;

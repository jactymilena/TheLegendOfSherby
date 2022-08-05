----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/22/2022 02:06:56 PM
-- Design Name: 
-- Module Name: PPUCore - Behavioral
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

entity PPUCore is
    Port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0);
           o_control : out STD_LOGIC_VECTOR (31 downto 27);
           o_actor_x : out STD_LOGIC_VECTOR (17 downto 9);
           o_actor_y : out STD_LOGIC_VECTOR (8 downto 0);
           o_actor_actif : out std_logic;
           o_actor_id: out STD_LOGIC_VECTOR (26 downto 23);
           o_ActorTile_id : out STD_LOGIC_VECTOR (25 downto 18);
           o_BgTile_id : out STD_LOGIC_VECTOR (25 downto 18)
           );
end PPUCore;

architecture Behavioral of PPUCore is
    signal op_code: STD_LOGIC_VECTOR(31 downto 27);
begin
    o_control       <= i_instruction(31 downto 27);
    o_actor_x       <= i_instruction(17 downto 9);
    o_actor_y       <= i_instruction(8 downto 0);
    o_actor_actif   <= i_instruction(22);
    o_actor_id      <= i_instruction(26 downto 23);
    o_ActorTile_id       <= i_instruction(22 downto 15);
    o_BgTile_id       <= i_instruction(25 downto 18);
end Behavioral;

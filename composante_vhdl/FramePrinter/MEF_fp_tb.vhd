----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 05:22:24 PM
-- Design Name: 
-- Module Name: MEF_fp_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEF_fp_tb is
--  Port ( );
end MEF_fp_tb;

architecture Behavioral of MEF_fp_tb is
--signaux
signal clk_tb, en_tb, rst_tb, en224, rst224, clk256, en256, rst256: std_logic := '0';
signal PositionX, PositionY, val_cpt224, val_cpt256: std_logic_vector(8 downto 0):= "000000000";
signal control: std_logic_vector (3 downto 0):= "0000";

constant c_clk_p_Period      : time :=  20 ns;  -- 50 MHz  -- frequence de l'horloge
constant c_delai   : time :=  40 ns;  -- delai entre changements test

--component
component MEF_fp is
    Port ( i_x : in STD_LOGIC_VECTOR (8 downto 0);
           i_y : in STD_LOGIC_VECTOR (8 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           i_cpt224 : in STD_LOGIC_VECTOR (8 downto 0);
           i_cpt256 : in STD_LOGIC_VECTOR (8 downto 0);
           o_en224 : out STD_LOGIC;
           o_rst224 : out STD_LOGIC;
           o_en256 : out STD_LOGIC;
           o_rst256 : out STD_LOGIC;
           o_control : out STD_LOGIC_VECTOR (3 downto 0));
end component MEF_fp;

begin
   ----------------------------------------------------------------------------
   -- instanciation
   ----------------------------------------------------------------------------
   inst_MEF:MEF_fp 
    Port map( 
           i_x => PositionX,
           i_y => PositionY,
           clk => clk_tb,
           reset => rst_tb,
           enable => en_tb,
           i_cpt224 => val_cpt224,
           i_cpt256 => val_cpt256,
           o_en224 => en224,
           o_rst224 => rst224,
           o_en256 => en256,
           o_rst256 => rst256,
           o_control => control
    ); 

   ----------------------------------------------------------------------------
   -- generation horloge  
   ----------------------------------------------------------------------------
 sim_clk_p:  process
   begin
      clk_tb <= '1';  -- init
      loop
         wait for c_clk_p_Period / 2;
         clk_tb <= not clk_tb; -- invert clock value
      end loop;
   end process;  
   
   tb: process
   begin
        wait for c_delai;
        rst_tb <= '1';
        wait for c_delai;
        wait for c_delai;
        rst_tb <='0';
        en_tb <= '1';
        
        --position X et Y/compteurs 256 et 224 bits
        for index_line in 0 to 224 loop
            wait for c_delai;
            PositionY <= PositionY + 1;
            val_cpt224 <= val_cpt224 + 1;
            
            for index_frame in 0 to 256 loop
                wait for c_delai;
                PositionX <= PositionX + 1;
                val_cpt256 <= val_cpt256 + 1;
            end loop;
        end loop;
        
        PositionY <= "000000000";
        val_cpt224 <= "000000000";
        PositionX <= "000000000";
        val_cpt256 <= "000000000";
                
   end process;
 
end Behavioral;

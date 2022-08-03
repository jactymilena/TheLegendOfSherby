----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2022 03:36:56 PM
-- Design Name: 
-- Module Name: actor_register - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.tuile_package.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity actor_register is
    Port ( i_set_actor_x        : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_actor_y        : in STD_LOGIC_VECTOR (8 downto 0);
           i_actor_id           : in STD_LOGIC_VECTOR (3 downto 0);
           i_global_x           : in STD_LOGIC_VECTOR (8 downto 0);
           i_global_y           : in STD_LOGIC_VECTOR (8 downto 0);
           i_we_pos             : in STD_LOGIC;
           i_we_actif           : in STD_LOGIC;
           i_we_tile            : in STD_LOGIC;
           i_tid                : in STD_LOGIC_VECTOR (7 downto 0);
           i_clk                : in STD_LOGIC;
           o_actor_actif        : out STD_LOGIC;
           o_tid                : out STD_LOGIC_VECTOR (7 downto 0);
           o_pixel_x            : out STD_LOGIC_VECTOR (3 downto 0);
           o_pixel_y            : out STD_LOGIC_VECTOR (3 downto 0));
end actor_register;

architecture Behavioral of actor_register is
    component actor is
    Port ( i_gb_x           : in STD_LOGIC_VECTOR (8 downto 0);
           i_gb_y           : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_x          : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_y          : in STD_LOGIC_VECTOR (8 downto 0);
           i_tid            : in STD_LOGIC_VECTOR (7 downto 0);
           i_actor_id       : in STD_LOGIC_VECTOR (3 downto 0);
           i_curr_actor_id  : in STD_LOGIC_VECTOR (3 downto 0);
           i_we_pos         : in STD_LOGIC;
           i_we_tile        : in STD_LOGIC;
           i_we_actif       : in STD_LOGIC;
           o_tid            : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           o_pix_x          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           o_pix_y          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           o_actif          : out STD_LOGIC;
           o_hit            : out STD_LOGIC := '0'); -- quand a 1, l'acteur se trouve a la pos globale
    end component;
    
    component selecteurActeur is
    Port ( hits : in STD_LOGIC_VECTOR (11 downto 0) := "000000000000" ;
           ActorId : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal s_hit               : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    signal s_actif             : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');

    -- Identifiant des tuiles des 12 acteurs
    signal s_tid_arr                : tableauTileId;
    signal s_aid_arr                : tableau_4;
    signal s_we_pos_arr             : STD_LOGIC_VECTOR (11 downto 0);
    signal s_we_aid                 : STD_LOGIC;
    signal s_curr_actor_id          : STD_LOGIC_VECTOR (3 downto 0);
    
    -- Pixels X et Y en sortie des 12 acteurs
    signal s_pix_x_arr : tableau_4;
    signal s_pix_y_arr : tableau_4;
    
    signal s_select_actor_id   : STD_LOGIC_VECTOR (3 downto 0);
    signal s_select_index      : INTEGER := 0;
    
begin
   
    inst_select :  selecteurActeur 
    Port map ( 
        hits    => s_hit,
        ActorId => s_select_actor_id
    );
   
   -- generation des 12 acteurs
   gen_actor_inst : 
   for I in 0 to 11 generate
      s_aid_arr(I) <= std_logic_vector(TO_UNSIGNED(I, i_actor_id'length));
      inst_actor : actor port map
        (
            i_gb_x          =>   i_global_x,     
            i_gb_y          =>   i_global_y,     
            i_set_x         =>   i_set_actor_x,  
            i_set_y         =>   i_set_actor_Y,  
            i_tid           =>   i_tid,     
            i_actor_id      =>   s_aid_arr(I),  
            i_curr_actor_id =>   i_actor_id,  
            i_we_pos        =>   i_we_pos,
            i_we_tile       =>   i_we_tile,
            i_we_actif      =>   i_we_actif,
            o_tid           =>   s_tid_arr(I),
            o_pix_x         =>   s_pix_x_arr(I),   
            o_pix_y         =>   s_pix_y_arr(I),
            o_hit           =>   s_hit(I),
            o_actif         =>   s_actif(I)
        );
   end generate gen_actor_inst;
       
   process(s_select_actor_id, s_tid_arr, s_pix_x_arr, s_pix_y_arr, s_actif)               
   begin
        for s_select_index in 0 to 11 loop
            if(to_integer(unsigned(s_select_actor_id)) = s_select_index) then
                o_tid           <= s_tid_arr(s_select_index); 
                o_pixel_x       <= s_pix_x_arr(s_select_index);
                o_pixel_y       <= s_pix_y_arr(s_select_index);
                o_actor_actif   <= s_actif(s_select_index);
                exit; -- break for loop
            end if;
        end loop;
    end process;

end Behavioral;

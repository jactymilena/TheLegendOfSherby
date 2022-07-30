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
           i_actorSetPos_we     : in STD_LOGIC;
           i_actorSetActive_we  : in STD_LOGIC;
           i_actorSetTile_we    : in STD_LOGIC;
           i_actorBuffer_we     : in STD_LOGIC;
           i_tid                : in STD_LOGIC_VECTOR (7 downto 0);
           i_clk                : in STD_LOGIC;
           o_actor_actif        : in STD_LOGIC;
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
               o_tid            : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
               o_pix_x          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
               o_pix_y          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
               o_hit            : out STD_LOGIC := '0');
    end component;
    
    component selecteurActeur is
    Port ( hits : in STD_LOGIC_VECTOR (11 downto 0) := "000000000000" ;
           ActorId : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    -- Identifiant des tuiles des 12 acteurs
    signal s_tid_a0   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a1   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a2   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a3   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a4   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a5   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a6   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a7   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a8   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a9   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a10  : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_tid_a11  : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    
    
    -- Pixels X en sortie des 12 acteurs
    signal s_x_a0   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a1   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a2   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a3   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a4   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a5   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a6   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a7   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a8   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a9   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a10  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_x_a11  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    
    -- Pixels Y en sortie des 12 acteurs
    signal s_y_a0   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a1   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a2   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a3   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a4   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a5   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a6   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a7   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a8   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a9   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a10  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_y_a11  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');   

    signal s_hit               : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal s_tid               : STD_LOGIC_VECTOR (7 downto 0);
    signal s_is_actif          : STD_LOGIC;
    signal s_select_actor_id   : STD_LOGIC_VECTOR (3 downto 0);
    signal s_curr_actor_id     : STD_LOGIC_VECTOR (3 downto 0);
    signal s_curr_actor_id_i   : INTEGER;

begin
    process(s_select_actor_id)
    begin
        case (s_select_actor_id) is 
          when "0000" =>
            o_tid       <= s_tid_a0; 
            o_pixel_x   <= s_x_a0;
            o_pixel_y   <= s_x_a0;
          when "0001" => 
            o_tid       <= s_tid_a1; 
            o_pixel_x   <= s_x_a1;
            o_pixel_y   <= s_x_a1;
          when "0010" => 
            o_tid       <= s_tid_a2; 
            o_pixel_x   <= s_x_a2;
            o_pixel_y   <= s_x_a2;
          when "0011" => 
            o_tid       <= s_tid_a3; 
            o_pixel_x   <= s_x_a3;
            o_pixel_y   <= s_x_a3;
          when "0100" => 
            o_tid       <= s_tid_a4; 
            o_pixel_x   <= s_x_a4;
            o_pixel_y   <= s_x_a4;            
          when "0101" => 
            o_tid       <= s_tid_a5; 
            o_pixel_x   <= s_x_a5;
            o_pixel_y   <= s_x_a5; 
          when "0110" => 
            o_tid       <= s_tid_a6;
            o_pixel_x   <= s_x_a6;
            o_pixel_y   <= s_x_a6; 
          when "0111" => 
            o_tid       <= s_tid_a7; 
            o_pixel_x   <= s_x_a7;
            o_pixel_y   <= s_x_a7; 
          when "1000" => 
            o_tid       <= s_tid_a8; 
            o_pixel_x   <= s_x_a8;
            o_pixel_y   <= s_x_a8;            
          when "1001" => 
            o_tid <= s_tid_a9; 
            o_pixel_x   <= s_x_a9;
            o_pixel_y   <= s_x_a9;       
          when "1010" => 
            o_tid <= s_tid_a10; 
            o_pixel_x   <= s_x_a10;
            o_pixel_y   <= s_x_a10;   
          when "1011" => 
            o_tid <= s_tid_a11; 
            o_pixel_x   <= s_x_a11;
            o_pixel_y   <= s_x_a11;     
          when others =>
       
       end case;
    end process;
    
    
    process(i_global_x, i_global_y)
    begin
        for s_curr_actor_id_i in 0 to 11 loop
            s_curr_actor_id <= std_logic_vector(TO_UNSIGNED(s_curr_actor_id_i, s_curr_actor_id'length));
        end loop;
    end process;
    
    
    
    inst_select :  selecteurActeur 
        Port map ( 
            hits    => s_hit,
            ActorId => s_select_actor_id
        );
  
    
    inst_actor0 : actor
        Port map ( 
               i_gb_x           => i_global_x,
               i_gb_y           => i_global_y,
               i_set_x          => i_set_actor_x,
               i_set_y          => i_set_actor_y,
               i_tid            => i_tid,
               i_actor_id       => "0000",
               i_curr_actor_id  => i_actor_id,
               i_we_pos         => i_actorSetPos_we,
               i_we_tile        => i_actorSetTile_we,
               o_tid            => s_tid_a0,
               o_pix_x          => s_x_a0,
               o_pix_y          => s_y_a0,
               o_hit            => s_hit(0)
        );
        
    inst_actor1 : actor
        Port map ( 
               i_gb_x           => i_global_x,
               i_gb_y           => i_global_y,
               i_set_x          => i_set_actor_x,
               i_set_y          => i_set_actor_y,
               i_tid            => i_tid,
               i_actor_id       => "0001",
               i_curr_actor_id  => i_actor_id,
               i_we_pos         => i_actorSetPos_we,
               i_we_tile        => i_actorSetTile_we,
               o_tid            => s_tid_a0,
               o_pix_x          => s_x_a0,
               o_pix_y          => s_y_a0,
               o_hit            => s_hit(1)
        );
        
    inst_actor2 : actor
        Port map ( 
               i_gb_x           => i_global_x,
               i_gb_y           => i_global_y,
               i_set_x          => i_set_actor_x,
               i_set_y          => i_set_actor_y,
               i_tid            => i_tid,
               i_actor_id       => "0010",
               i_curr_actor_id  => i_actor_id,
               i_we_pos         => i_actorSetPos_we,
               i_we_tile        => i_actorSetTile_we,
               o_tid            => s_tid_a0,
               o_pix_x          => s_x_a0,
               o_pix_y          => s_y_a0,
               o_hit            => s_hit(2)
        );   
        
    inst_actor3 : actor
        Port map ( 
               i_gb_x           => i_global_x,
               i_gb_y           => i_global_y,
               i_set_x          => i_set_actor_x,
               i_set_y          => i_set_actor_y,
               i_tid            => i_tid,
               i_actor_id       => "0011",
               i_curr_actor_id  => i_actor_id,
               i_we_pos         => i_actorSetPos_we,
               i_we_tile        => i_actorSetTile_we,
               o_tid            => s_tid_a0,
               o_pix_x          => s_x_a0,
               o_pix_y          => s_y_a0,
               o_hit            => s_hit(3)
        ); 
    
    inst_actor4 : actor
            Port map ( 
                   i_gb_x           => i_global_x,
                   i_gb_y           => i_global_y,
                   i_set_x          => i_set_actor_x,
                   i_set_y          => i_set_actor_y,
                   i_tid            => i_tid,
                   i_actor_id       => "0100",
                   i_curr_actor_id  => i_actor_id,
                   i_we_pos         => i_actorSetPos_we,
                   i_we_tile        => i_actorSetTile_we,
                   o_tid            => s_tid_a0,
                   o_pix_x          => s_x_a0,
                   o_pix_y          => s_y_a0,
                   o_hit            => s_hit(4)
            ); 

    inst_actor5 : actor 
            Port map ( 
                   i_gb_x           => i_global_x,
                   i_gb_y           => i_global_y,
                   i_set_x          => i_set_actor_x,
                   i_set_y          => i_set_actor_y,
                   i_tid            => i_tid,
                   i_actor_id       => "0101",
                   i_curr_actor_id  => i_actor_id,
                   i_we_pos         => i_actorSetPos_we,
                   i_we_tile        => i_actorSetTile_we,
                   o_tid            => s_tid_a0,
                   o_pix_x          => s_x_a0,
                   o_pix_y          => s_y_a0,
                   o_hit            => s_hit(5)
            ); 
            
      inst_actor6 : actor 
            Port map ( 
                   i_gb_x           => i_global_x,
                   i_gb_y           => i_global_y,
                   i_set_x          => i_set_actor_x,
                   i_set_y          => i_set_actor_y,
                   i_tid            => i_tid,
                   i_actor_id       => "0110",
                   i_curr_actor_id  => i_actor_id,
                   i_we_pos         => i_actorSetPos_we,
                   i_we_tile        => i_actorSetTile_we,
                   o_tid            => s_tid_a0,
                   o_pix_x          => s_x_a0,
                   o_pix_y          => s_y_a0,
                   o_hit            => s_hit(6)
            );

      inst_actor7 : actor 
              Port map ( 
                     i_gb_x           => i_global_x,
                     i_gb_y           => i_global_y,
                     i_set_x          => i_set_actor_x,
                     i_set_y          => i_set_actor_y,
                     i_tid            => i_tid,
                     i_actor_id       => "0111",
                     i_curr_actor_id  => i_actor_id,
                     i_we_pos         => i_actorSetPos_we,
                     i_we_tile        => i_actorSetTile_we,
                     o_tid            => s_tid_a0,
                     o_pix_x          => s_x_a0,
                     o_pix_y          => s_y_a0,
                     o_hit            => s_hit(7)
              );

          inst_actor8 : actor
              Port map ( 
                     i_gb_x           => i_global_x,
                     i_gb_y           => i_global_y,
                     i_set_x          => i_set_actor_x,
                     i_set_y          => i_set_actor_y,
                     i_tid            => i_tid,
                     i_actor_id       => "1000",
                     i_curr_actor_id  => i_actor_id,
                     i_we_pos         => i_actorSetPos_we,
                     i_we_tile        => i_actorSetTile_we,
                     o_tid            => s_tid_a0,
                     o_pix_x          => s_x_a0,
                     o_pix_y          => s_y_a0,
                     o_hit            => s_hit(8)
              );   

          inst_actor9 : actor
              Port map ( 
                     i_gb_x           => i_global_x,
                     i_gb_y           => i_global_y,
                     i_set_x          => i_set_actor_x,
                     i_set_y          => i_set_actor_y,
                     i_tid            => i_tid,
                     i_actor_id       => "1001",
                     i_curr_actor_id  => i_actor_id,
                     i_we_pos         => i_actorSetPos_we,
                     i_we_tile        => i_actorSetTile_we,
                     o_tid            => s_tid_a0,
                     o_pix_x          => s_x_a0,
                     o_pix_y          => s_y_a0,
                     o_hit            => s_hit(9)
              ); 

          inst_actor10 : actor
                  Port map ( 
                         i_gb_x           => i_global_x,
                         i_gb_y           => i_global_y,
                         i_set_x          => i_set_actor_x,
                         i_set_y          => i_set_actor_y,
                         i_tid            => i_tid,
                         i_actor_id       => "1010",
                         i_curr_actor_id  => i_actor_id,
                         i_we_pos         => i_actorSetPos_we,
                         i_we_tile        => i_actorSetTile_we,
                         o_tid            => s_tid_a0,
                         o_pix_x          => s_x_a0,
                         o_pix_y          => s_y_a0,
                         o_hit            => s_hit(10)
                  ); 

          inst_actor11 : actor 
                  Port map ( 
                         i_gb_x           => i_global_x,
                         i_gb_y           => i_global_y,
                         i_set_x          => i_set_actor_x,
                         i_set_y          => i_set_actor_y,
                         i_tid            => i_tid,
                         i_actor_id       => "1011",
                         i_curr_actor_id  => i_actor_id,
                         i_we_pos         => i_actorSetPos_we,
                         i_we_tile        => i_actorSetTile_we,
                         o_tid            => s_tid_a0,
                         o_pix_x          => s_x_a0,
                         o_pix_y          => s_y_a0,
                         o_hit            => s_hit(11)
                  ); 

end Behavioral;

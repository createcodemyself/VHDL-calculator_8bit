library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity calculator_8bit is
Port( choice : in std_logic_vector(1 downto 0);
		X,Y : in std_logic_vector(7 downto 0);
		S : buffer std_logic_vector(15 downto 0);
		seven_segment1,seven_segment2,seven_segment3,
		seven_segment4,seven_segment5: out std_logic_vector(6 downto 0);
		bcd_1, bcd_2, bcd_3, bcd_4, bcd_5 : buffer std_logic_vector(3 downto 0));
end calculator_8bit;

architecture behavior of calculator_8bit is
signal result1 : std_logic_vector(8 downto 0);
signal result2 : std_logic_vector(8 downto 0);
signal result3 : std_logic_vector(15 downto 0);
signal result4 : std_logic_vector(8 downto 0);
signal result5 : std_logic_vector(7 downto 0);
signal bcd1 : std_logic_vector( 3 downto 0);
signal bcd2 : std_logic_vector( 3 downto 0);
signal bcd3 : std_logic_vector( 3 downto 0);
signal bcd4 : std_logic_vector( 3 downto 0);
signal bcd5 : std_logic_vector( 3 downto 0);
signal a : std_logic_vector(15 downto 0);
signal b : std_logic_vector(15 downto 0);
signal b1 : std_logic_vector(15 downto 0);
signal c : std_logic_vector(15 downto 0);
signal c1 : std_logic_vector(15 downto 0);
signal d : std_logic_vector(15 downto 0);
signal d1 : std_logic_vector(15 downto 0);
signal e : std_logic_vector(15 downto 0);

begin
p1: process(choice)
begin
	if (choice = "00")	then	-- add
		result1 <= ('0' & X) + ('0' & Y);
		S <=("0000000" & result1(8 downto 0));
		a <= std_logic_vector(unsigned(S)/100);
		bcd3 <= a(3) & a(2) & a(1) & a(0);
		bcd_3 <= bcd3;
		b <= std_logic_vector(unsigned(S) rem 100);
		b1 <= std_logic_vector(unsigned(b) / 10);
		bcd4 <= b1(3) & b1(2) & b1(1) & b1(0);
		bcd_4 <= bcd4;
		c <= std_logic_vector(unsigned(b) rem 10);
		bcd5 <= c(3) & c(2) & c(1) & c(0);
		bcd_5 <= bcd5;
		bcd_1 <= "0000";
		bcd_2 <= "0000";
		
	elsif (choice = "01")	then --sub
		result2 <= ('0' & X) - ('0' & Y);
		S <=("0000000" & result2(8 downto 0));
		a <= std_logic_vector(unsigned(S)/100);
		bcd3 <= a(3) & a(2) & a(1) & a(0);
		bcd_3 <= bcd3;
		b <= std_logic_vector(unsigned(S) rem 100);
		b1 <= std_logic_vector(unsigned(b) / 10);
		bcd4 <= b1(3) & b1(2) & b1(1) & b1(0);
		bcd_4 <= bcd4;
		c <= std_logic_vector(unsigned(b) rem 10);
		bcd5 <= c(3) & c(2) & c(1) & c(0);
		bcd_5 <= bcd5;
		bcd_1 <= "0000";
		bcd_2 <= "0000";
		
	elsif (choice = "10") then		--mul
		result3  <= (X * Y);	
		S <=result3(15 downto 0);
		a <= std_logic_vector(unsigned(S)/10000);
		bcd1 <= a(3) & a(2) & a(1) & a(0);
		bcd_1 <= bcd1;
		b <= std_logic_vector(unsigned(S) rem 10000);
		b1 <= std_logic_vector(unsigned(b) / 1000);
		bcd2 <= b1(3) & b1(2) & b1(1) & b1(0);
		bcd_2 <= bcd2;
		c <= std_logic_vector(unsigned(b) rem 1000);
		c1 <= std_logic_vector(unsigned(c) / 100);
		bcd3 <= c1(3) & c1(2) & c1(1) & c1(0);
		bcd_3 <= bcd3;
		d <= std_logic_vector(unsigned(c) rem 100);
		d1 <= std_logic_vector(unsigned(d) / 10);
		bcd4 <= d1(3) & d1(2) & d1(1) & d1(0);
		bcd_4 <= bcd4;
		e <= std_logic_vector(unsigned(d) rem 10);
		bcd5 <= e(3) & e(2) & e(1) & e(0); 
		bcd_5 <= bcd5;
		
	elsif (choice = "11") then		--div
		result4 <= std_logic_vector(('0' & unsigned(X))/('0' &unsigned(Y)));
		S <= ("0000000" & result4(8 downto 0));
		a <= std_logic_vector(unsigned(S)/100);
		bcd1 <= a(3) & a(2) & a(1) & a(0);
		bcd_1 <= bcd1;
		b <= std_logic_vector(unsigned(S) rem 100);
		b1 <= std_logic_vector(unsigned(b) / 10);
		bcd2 <= b1(3) & b1(2) & b1(1) & b1(0);
		bcd_2 <= bcd2;
		c <= std_logic_vector(unsigned(b) rem 10);
		bcd3 <= c(3) & c(2) & c(1) & c(0);
		bcd_3 <= bcd3;
		result5 <= std_logic_vector((unsigned(X))rem (unsigned(Y)));
		d <= result5 * "00001010";
		d1 <= std_logic_vector(unsigned(d) / unsigned(Y));
		bcd_5 <= d1(3) & d1(2) & d1(1) & d1(0);		
		bcd_4 <= "1011";
	end if;
	end process;

p2 : process(bcd_1)
	begin
		case bcd_1 is
			when "0000" => seven_segment1 <= "1000000";
			when "0001" => seven_segment1 <= "1111001";
			when "0010" => seven_segment1 <= "0100100";
			when "0011" => seven_segment1 <= "0110000";
			when "0100" => seven_segment1 <= "0011001";
			when "0101" => seven_segment1 <= "0010010";
			when "0110" => seven_segment1 <= "0000010";
			when "0111" => seven_segment1 <= "1011000";
			when "1000" => seven_segment1 <= "0000000";
			when "1001" => seven_segment1 <= "0010000";
			when others => seven_segment1 <= "1111111";
		end case;
	end process;
	
p3 : process(bcd_2)
	begin
		case bcd_2 is
			when "0000" => seven_segment2 <= "1000000";
			when "0001" => seven_segment2 <= "1111001";
			when "0010" => seven_segment2 <= "0100100";
			when "0011" => seven_segment2 <= "0110000";
			when "0100" => seven_segment2 <= "0011001";
			when "0101" => seven_segment2 <= "0010010";
			when "0110" => seven_segment2 <= "0000010";
			when "0111" => seven_segment2 <= "1011000";
			when "1000" => seven_segment2 <= "0000000";
			when "1001" => seven_segment2 <= "0010000";
			when others => seven_segment2 <= "1111111";
		end case;
	end process;
	
p4 : process(bcd_3)
	begin
		case bcd_3 is
			when "0000" => seven_segment3 <= "1000000";
			when "0001" => seven_segment3 <= "1111001";
			when "0010" => seven_segment3 <= "0100100";
			when "0011" => seven_segment3 <= "0110000";
			when "0100" => seven_segment3 <= "0011001";
			when "0101" => seven_segment3 <= "0010010";
			when "0110" => seven_segment3 <= "0000010";
			when "0111" => seven_segment3 <= "1011000";
			when "1000" => seven_segment3 <= "0000000";
			when "1001" => seven_segment3 <= "0010000";
			when others => seven_segment3 <= "1111111";
		end case;
	end process;
	
p5 : process(bcd_4)
	begin
		case bcd_4 is
			when "0000" => seven_segment4 <= "1000000";
			when "0001" => seven_segment4 <= "1111001";
			when "0010" => seven_segment4 <= "0100100";
			when "0011" => seven_segment4 <= "0110000";
			when "0100" => seven_segment4 <= "0011001";
			when "0101" => seven_segment4 <= "0010010";
			when "0110" => seven_segment4 <= "0000010";
			when "0111" => seven_segment4 <= "1011000";
			when "1000" => seven_segment4 <= "0000000";
			when "1001" => seven_segment4 <= "0010000";
			when "1011" => seven_segment4 <= "0111111";
			when others => seven_segment4 <= "1111111";
		end case;
	end process;
	
p6 : process(bcd_5)
	begin
		case bcd_5 is
			when "0000" => seven_segment5 <= "1000000";
			when "0001" => seven_segment5 <= "1111001";
			when "0010" => seven_segment5 <= "0100100";
			when "0011" => seven_segment5 <= "0110000";
			when "0100" => seven_segment5 <= "0011001";
			when "0101" => seven_segment5 <= "0010010";
			when "0110" => seven_segment5 <= "0000010";
			when "0111" => seven_segment5 <= "1011000";
			when "1000" => seven_segment5 <= "0000000";
			when "1001" => seven_segment5 <= "0010000";
			when others => seven_segment5 <= "1111111";
		end case;
	end process;
end behavior;

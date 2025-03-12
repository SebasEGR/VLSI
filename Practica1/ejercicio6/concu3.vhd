library ieee;
use ieee.std_logic_1164.all;

entity concu3 is
-- Declaración de la entidad con sus puertos de entrada y salida.
-- Los displays de 7 segmentos ssg0, ssg1, ssg2 y ssg3 son las salidas.
port( 
    clk: in std_logic; -- Entrada del reloj principal.
    ssg0: out std_logic_vector(6 downto 0); -- Salida para el display de las unidades de segundos.
    ssg1: out std_logic_vector(6 downto 0); -- Salida para el display de las decenas de segundos.
    ssg2: out std_logic_vector(6 downto 0); -- Salida para el display de las unidades de minutos.
    ssg3: out std_logic_vector(6 downto 0)  -- Salida para el display de las decenas de minutos.
);
end entity;

architecture a of concu3 is
-- Declaración de señales internas.
signal clkl: std_logic :='0'; -- Señal de reloj interno con frecuencia reducida.
signal contador: integer range 0 to 25000000; -- Contador para dividir la frecuencia de reloj.
signal conteo1, conteo2, conteo3, conteo4 : integer := 0; -- Contadores para unidades y decenas.
signal bandera1: std_logic :='0'; -- Bandera para controlar el incremento de las decenas de segundos.
signal bandera2: std_logic :='0'; -- Bandera para controlar el incremento de las unidades de minutos.
signal bandera3: std_logic :='0'; -- Bandera para controlar el incremento de las decenas de minutos.


begin

-- Proceso para dividir la frecuencia del reloj.
process(clk)
    -- Este proceso reduce la frecuencia de 50 MHz a 1 Hz.
    -- Al llegar a 25 millones de ciclos, se alterna el estado de la señal `clkl`.
    begin 
        if (rising_edge(clk)) then
            if (contador = 25000000) then
                contador <= 0; -- Reinicia el contador al llegar al límite.
                clkl <= not clkl; -- Cambia el estado del reloj interno.
            else 
                contador <= contador + 1; -- Incrementa el contador.
            end if;
        end if;
    end process;

-- Proceso para contar las unidades de minutos.
process(clkl)
    -- Este proceso cuenta de 0 a 9 y activa la bandera1 al reiniciar.
    begin 
        if(rising_edge(clkl)) then
            if (conteo1 = 9) then
                conteo1 <= 0; -- Reinicia el contador de unidades de segundos.
                bandera1 <='1'; -- Activa la bandera para incrementar las decenas de minutos.
            else
                conteo1 <= conteo1 + 1; -- Incrementa el contador.
                bandera1 <='0'; -- Desactiva la bandera.
            end if;
        end if;
    end process;

-- Proceso para contar las decenas de minutos.
process(bandera1)
    -- Este proceso cuenta de 0 a 5 para las decenas de minutos.
    begin 
        if(rising_edge(bandera1)) then
            if (conteo2 = 5) then
                conteo2 <= 0; -- Reinicia el contador de decenas de minutos.
                bandera2 <='1'; -- Activa la bandera para incrementar las unidades de horas.
            else
                conteo2 <= conteo2 + 1; -- Incrementa el contador.
                bandera2 <='0'; -- Desactiva la bandera.
            end if;
        end if;
    end process;

-- Proceso para contar las unidades de horas.
process(bandera2)
    -- Este proceso maneja las unidades de minutos y las decenas de horas.
    begin 
        if(rising_edge(bandera2)) then
            if (conteo3 = 9 OR (conteo3 = 3 and conteo4 = 2)) then
                conteo3 <= 0; -- Reinicia las unidades de horas.
                bandera3 <='1'; -- Activa la bandera para incrementar las decenas de horas.
            else
                conteo3 <= conteo3 + 1; -- Incrementa las unidades de horas.
                bandera3 <='0'; -- Desactiva la bandera.
            end if;
        end if;
    end process;

-- Proceso para contar las decenas de horas.
process(bandera3)
    -- Este proceso cuenta las decenas de horas y reinicia al llegar a 2.
    begin 
        if(rising_edge(bandera3)) then
            if (conteo4 = 2) then
                conteo4 <= 0; -- Reinicia las decenas de horas.
            else
                conteo4 <= conteo4 + 1; -- Incrementa las decenas de horas.
            end if;
        end if;
    end process;

-- Multiplexores para asignar los valores a los displays de 7 segmentos.
with conteo1 select
    ssg0 <= "1000000" when 0, -- Configuración para cada dígito del display.
             "1111001" when 1, 
             "0100100" when 2,
             "0110000" when 3,
             "0011001" when 4,
             "0010010" when 5,
             "0000010" when 6,
             "1111000" when 7,
             "0000000" when 8,
             "0011000" when 9,
             "1000000" when others;

with conteo2 select
    ssg1 <= "1000000" when 0, -- Decenas de minutos.
             "1111001" when 1,
             "0100100" when 2,
             "0110000" when 3,
             "0011001" when 4,
             "0010010" when 5,
             "1000000" when others;

with conteo3 select
    ssg2 <= "1000000" when 0, -- Unidades de horas.
             "1111001" when 1,
             "0100100" when 2,
             "0110000" when 3,
             "0011001" when 4,
             "0010010" when 5,
             "0000010" when 6,
             "1111000" when 7,
             "0000000" when 8,
             "0011000" when 9,
             "1000000" when others;

with conteo4 select
    ssg3 <= "1000000" when 0, -- Decenas de horas.
             "1111001" when 1,
             "0100100" when 2,
             "1000000" when others;

end architecture;

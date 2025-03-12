library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'conta', que es un contador de 10 estados
entity conta is
  port (
    clk      : in std_logic;                -- Entrada de reloj
    reset    : in std_logic;                -- Entrada de reset (para reiniciar el contador)
    SalMoore : out std_logic_vector(3 downto 0)  -- Salida de 4 bits que representa el estado actual
  );
end entity conta;

-- Arquitectura que define el comportamiento del contador (secuencial)
architecture arqconta of conta is
  -- Definición de un tipo 'state' que es un vector de 4 bits
  subtype state is std_logic_vector(3 downto 0);
  
  -- Señales para el estado actual y el siguiente estado
  signal present_state, next_state : std_logic_vector(3 downto 0);

  -- Definición de los 10 estados que tendrá el contador
  constant e0 : state := "0000";  -- Estado 0
  constant e1 : state := "0001";  -- Estado 1
  constant e2 : state := "0010";  -- Estado 2
  constant e3 : state := "0011";  -- Estado 3
  constant e4 : state := "0100";  -- Estado 4
  constant e5 : state := "0101";  -- Estado 5
  constant e6 : state := "0110";  -- Estado 6
  constant e7 : state := "0111";  -- Estado 7
  constant e8 : state := "1000";  -- Estado 8
  constant e9 : state := "1001";  -- Estado 9
begin
  -- Proceso que maneja el cambio de estado con cada flanco ascendente del reloj
  process (clk)
  begin
    if rising_edge(clk) then   -- Detecta el flanco ascendente del reloj
      if reset = '0' then      -- Si el reset está activo (en '0'), el contador se reinicia
        present_state <= e0;   -- El contador se pone en el estado inicial (e0)
      else
        present_state <= next_state;  -- Si no hay reset, el estado actual pasa al siguiente estado
      end if;
    end if;
  end process;

  -- Proceso que define la lógica de transición entre los estados
  process (present_state)
  begin
    -- Dependiendo del estado actual, se define el siguiente estado
    case present_state is
      when e0     => next_state <= e1;  -- Si el estado es e0, el siguiente es e1
      when e1     => next_state <= e2;  -- Si el estado es e1, el siguiente es e2
      when e2     => next_state <= e3;  -- Y así sucesivamente
      when e3     => next_state <= e4;
      when e4     => next_state <= e5;
      when e5     => next_state <= e6;
      when e6     => next_state <= e7;
      when e7     => next_state <= e8;
      when e8     => next_state <= e9;
      when e9     => next_state <= e0;  -- Si el estado es e9, se vuelve al estado e0
      when others =>
        next_state <= e0;  -- En caso de un estado inesperado, se regresa al estado e0
    end case;

    -- La salida 'SalMoore' refleja el estado actual del contador
    SalMoore <= present_state;
  end process;
end architecture;

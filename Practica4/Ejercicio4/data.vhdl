library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'data', que es una máquina de estados que cuenta en decrementos
entity data is
  port (
    clk   : in std_logic;        -- Entrada de reloj (clk) para la sincronización de las operaciones
    reset : in std_logic;        -- Entrada de reset para reiniciar el contador
    ret   : out integer          -- Salida 'ret' que mostrará el valor del estado actual
  );
end entity data;

-- Arquitectura que define el comportamiento de la máquina de estados
architecture arqdata of data is
  -- Definición de un tipo 'state' como un valor de tipo entero
  subtype state is integer;

  -- Señales que mantienen el estado actual y el siguiente estado de la máquina
  signal present_state, next_state : integer;

  -- Definición de los 9 estados posibles que tendrá la máquina
  constant e0 : state := 1025;  -- Estado e0
  constant e1 : state := 516;  -- Estado e1
  constant e2 : state := 256;  -- Estado e2
  constant e3 : state := 128;  -- Estado e3
  constant e4 : state := 64;  -- Estado e4
  constant e5 : state := 32;  -- Estado e5
  constant e6 : state := 16;  -- Estado e6
  constant e7 : state := 8;  -- Estado e7
  constant e8 : state := 4;  -- Estado e8
begin
  -- Proceso que maneja el cambio de estado en cada flanco ascendente del reloj
  process (clk)
  begin
    if rising_edge(clk) then   -- Detecta el flanco ascendente de la señal 'clk'
      if reset = '0' then      -- Si el reset está activo (en '0'), el contador se reinicia
        present_state <= e0;   -- El contador se pone en el estado inicial (e0)
      else
        present_state <= next_state;  -- Si no hay reset, el estado actual pasa al siguiente estado
      end if;
    end if;
  end process;

  -- Proceso que define las transiciones entre los estados
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
      when e8     => next_state <= e0;  -- Si el estado es e8, se vuelve al estado e0
      when others =>
        next_state <= e0;  -- En caso de un estado inesperado, se regresa al estado e0
    end case;

    -- La salida 'ret' refleja el estado actual de la máquina
    ret <= present_state;
  end process;
end architecture;

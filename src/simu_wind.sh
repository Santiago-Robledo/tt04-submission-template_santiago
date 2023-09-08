#!/bin/bash
# Variables predeterminadas
archivo=""
flag_v=false
flag_c=false
flag_r=false

# Funcion para mostrar el mensaje de ayuda
mostrar_ayuda() {
    echo "Use: simu_wind.sh <file> [options]"
    echo "Options:"
    echo "  none: Compile, simulate and open viewer."
    echo "    -c: Just compile code."
    echo "    -r: Just run simulation."
    echo "    -v: Just open wave viewer."
    echo "It is possible to use more than one option at the same time."
}

# Procesar los argumentos de linea de comandos
while [[ $# -gt 0 ]]; do
    case $1 in
        -v) flag_v=true; shift;;
        -c) flag_c=true; shift;;
        -r) flag_r=true; shift;;
         *)
             if [[ $1 == -* ]]; then
                echo "Invalid option: $1"
                mostrar_ayuda
                read -p "Press enter to continue"
                exit 1
            else
                archivo=$1
                shift
            fi
            ;;
    esac
done

# Verificar si se proporciono el nombre del archivo
if [[ -z $archivo ]]; then
    echo "You must specify the file name."
    mostrar_ayuda
    read -p "Press enter to continue"
    exit 1
fi

# Generar nombres dinamicos
v=".v"
vvp=".vvp"
vcd=".vcd"
v_file="${archivo}${v}"
vvp_file="${archivo}${vvp}"
vcd_file="${archivo}${vcd}"

# Verificar si el archivo existe
if [[ ! -e $v_file ]]; then
    echo "The file $v_file does not exit."
    mostrar_ayuda
    read -p "Press enter to continue"
    exit 1
fi

# Ejecutar comandos en secuencia

# Calcular tiempo
TIMEFORMAT='It took %R seconds.'
time {

# Accion dependiendo de ninguna bandera activa
if [[ $flag_c = false && $flag_r = false &&  $flag_v = false ]]; then
    echo "1. Compiling verilog code..."
    iverilog -o $vvp_file $v_file
    echo "2. Runing simulation..."
    vvp $vvp_file
    echo "3. Opening wave viewer.."
    start gtkwave $vcd_file
    
fi

# Accion dependiendo de la bandera -c
if [[ $flag_c = true ]]; then
    echo "1. Compiling verilog code..."
    iverilog -o $vvp_file $v_file
fi

# Accion dependiendo de la bandera -s
if [[ $flag_r = true ]]; then
    echo "2. Runing simulation..."
    vvp $vvp_file
fi

# Accion dependiendo de la bandera -v
if [[ $flag_v = true ]]; then
    echo "3. Opening wave viewer.."
    start gtkwave $vcd_file
fi

}
read -p "Press enter to continue"

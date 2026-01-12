# PD2 Loot Filter Switcher for Linux and my own PD2 Saves

Este repositorio contiene una utilidad para gestionar los filtros de loot (loot filters) en **Project Diablo 2** cuando se ejecuta en entornos Linux (Wine/Proton). Y mis salvas personales de PD2.

## Script: pd2-switch-loot-filter.sh

Se incluye un nuevo script Bash, `pd2-switch-loot-filter.sh`, que permite a los usuarios alternar fácilmente entre los filtros de loot de **Erazure** y **Kryszard** para Project Diablo 2.

### Configuración previa

Antes de ejecutarlo, debes configurar la ruta de instalación de tu juego dentro del script. Edita el archivo y busca la sección de **Settings**:

```bash
# Dentro de pd2-switch-loot-filter.sh
PD2_DIR="$HOME/Games/Diablo II/ProjectD2"

```

### Instalación y Uso

Para utilizar el script, otorga permisos de ejecución y lánzalo desde tu terminal de Linux pasando como argumento el filtro que deseas activar:

1. **Dar permisos de ejecución:**
```bash
chmod 755 ./pd2-switch-loot-filter.sh

```


2. **Cambiar al filtro de Erazure (E):**
```bash
./pd2-switch-loot-filter.sh E

```


3. **Cambiar al filtro de Kryszard (K):**
```bash
./pd2-switch-loot-filter.sh K

```


---

**Nota:** Asegúrate de que el juego esté cerrado al realizar el cambio para evitar conflictos con los archivos cargados en memoria.

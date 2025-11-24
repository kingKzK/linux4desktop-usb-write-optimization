Por defecto, Linux optimiza el rendimiento del sistema usando un caché de RAM dinámico. Esto es excelente para el rendimiento general, pero en unidades USB puede causar que la transferencia parezca terminar antes de que los datos se escriban físicamente. Este script ajusta ese parámetro para ofrecer una experiencia de usuario más realista sin sacrificar el rendimiento del SSD.

Optimizacion probada en Linux Mint 22.04

Para activar

sudo sh ./usb_transf_optimization.sh

Para desactivar

sudo sh ./disable_usb_transf_optimization.sh

Este "problema" puede agarrar a un usuario desprevenido en Linux Mint, y hacerle creer que sus archivos ya se transfirieron a su unidad USB cuando aún falta y mucho, desconectar prematuramente la unidad y perder datos.

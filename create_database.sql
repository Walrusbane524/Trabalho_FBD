CREATE DATABASE BDSpotPer
ON PRIMARY
(NAME = 'primarioUm',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\primarioUm.mdf',
    SIZE = 5MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%),
FILEGROUP secundario
(NAME = 'secundarioUm',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\secundarioUm.ndf',
    SIZE = 1MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%),
(NAME = 'secundarioDois',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\secundarioDois.ndf',
    SIZE = 1MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%),
FILEGROUP terciario
(NAME = 'terciario',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\terciario.ndf',
    SIZE = 1MB,
    MAXSIZE = 10MB,
    FILEGROWTH = 100%)
LOG ON
(NAME = 'Log',
    FILENAME = 'C:\Nova pasta\Trabalho_FBD\database\Log.ldf',
    SIZE = 1MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 100%)

ALTER DATABASE BDSpotPer
MODIFY FILEGROUP secundario DEFAULT;
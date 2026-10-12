@echo off
echo Starting PremMart Server...
cd /d "%~dp0"
mvn compile exec:java
pause

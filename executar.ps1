# Configuracoes
$JAR_CUP = "java-cup-11b.jar"
$JAR_RUNTIME = "java-cup-11b-runtime.jar"

Write-Host "`nINICIANDO PROCESSO DE COMPILACAO"

# 1. Geracao dos analisadores
try {
    jflex Scanner.flex
    java -jar $JAR_CUP -parser Parser Parser.cup
    javac -cp ".;$JAR_RUNTIME" *.java
} catch {
    Write-Host "ERRO: Falha na preparacao"
    exit
}

# 2. Execucao
Write-Host "`nEXECUTANDO ANALISADOR"
try {
    java -cp ".;$JAR_RUNTIME" Parser
} catch {
    Write-Host "ERRO NA EXECUCAO"
    Write-Host $_.Exception.Message
}

Write-Host "`nProcesso concluido. Pressione Enter para sair..."
[Console]::ReadKey()
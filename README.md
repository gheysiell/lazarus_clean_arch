# lazarus_clean_arch

## Descrição

Essa é a documentação do projeto **lazarus_clean_arch**, exemplificando o uso de clean architecture.

## Explicação

A Clean Architecture consiste em isolar o Domínio / Regras de negócio do "mundo externo", que são por exemplo: Bancos de dados, Interfaces gráficas, APIs...

Fazemos isso colocando oque é referente a regras de negócio e as entidades (classes) que representam a regra de negócio de determinado ramo em Domain, oque conecta o Domain com o que é externo são as Interfaces, que ficam desacopladas do que é externo, isso é possível porque uma Interface não diz como fazer, e sim oque fazer, sendo assim, não conhecendo as classes concretas necessárias para realizar determinada ação, isso também é chamado de inversão de dependência.

A vantagem disso não é apenas isolar o domínio, mas ter as camadas bem divididas e fazendo determinada coisa no seu devido lugar, por exemplo, na pasta Presentation tem só oque é relacionado a interface gráfica, e na pasta Data só oque é relacionado a dados, trazendo uma vantagem gigantesca na manutenção do projeto, e trazendo até uma satisfação em dar manutenção, sabendo que está fazendo a coisa certa em cada camada, isso influencia até no versionamento de código por saber que um arquivo alterou só determinada camada pelo mesmo motivo de cada camada ter seu propósito bem definido, e principalmente a facilidade de implementar testes automatizados, garantindo uma boa qualidade do projeto.

## Estatísticas do projeto

- **Linhas de código**: 1.371
- **Arquivos**: 16
- **Pastas**: 21
- **Telas**: 2
- **Pacotes**: 5
- **Média de linhas por arquivo**: 86
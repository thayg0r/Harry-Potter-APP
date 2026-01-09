# 🧙‍♂️ Harry Potter Flutter App

Aplicativo Flutter desenvolvido como teste técnico, consumindo a **Harry Potter API**, com foco em **arquitetura limpa, boa experiência do usuário e princípios SOLID**.

---

## 📱 Funcionalidades

- 🔍 Listagem de todos os personagens da obra
- 🏠 Filtro de personagens por casa
- 🏰 Listagem das casas e seus respectivos personagens
- 👤 Visualização detalhada de um personagem
- ✨ Listagem de magias
- 📦 Cache local para navegação offline
- 🌗 Tema claro e escuro (segue o sistema operacional)
- 🌍 Suporte a múltiplos idiomas (PT / EN)
- 🎨 Interface inspirada no universo Harry Potter

---

## 🏗️ Arquitetura

O projeto foi desenvolvido seguindo **Clean Architecture**, com separação clara de responsabilidades:

```
lib/
 ├─ core
 │  ├─ dio
 │  ├─ error
 │  ├─ network
 │  └─ theme
 ├─ features
 │  ├─ characters
 │  │  ├─ data
 │  │  ├─ domain
 │  │  └─ presentation
 │  └─ spells
 │     ├─ data
 │     ├─ domain
 │     └─ presentation
 └─ l10n
```

### Camadas
- **Data**: Datasources (remoto e local), models e implementações de repositórios
- **Domain**: Entidades, contratos de repositório e casos de uso
- **Presentation**: UI e gerenciamento de estado com **BLoC**

---

## 🧠 Princípios Aplicados

- SOLID
- Clean Architecture
- Injeção de dependências
- Separação de responsabilidades
- Gerenciamento de estado com BLoC
- Tratamento de erros e estados de loading
- Fallback automático para cache offline

---

## 🌐 API

Aplicativo consome a API pública:

- **Harry Potter API**  
  Base URL:  
  `https://hp-api.onrender.com/api`

Endpoints utilizados:
- `/characters`
- `/characters/house/{house}`
- `/spells`

---

## 📦 Cache & Offline

- Cache local implementado com `SharedPreferences`
- Dados são armazenados automaticamente após chamadas remotas
- Caso a API esteja indisponível, o app utiliza os dados cacheados

---

## 🧪 Testes

- Testes unitários implementados para:
  - Casos de uso
  - BLoC de personagens

---

## 🎨 UI / UX

- SliverAppBar com imagem do personagem
- Animações suaves e transições naturais
- Componentes reutilizáveis
- Navegação clara, mantendo o histórico de telas
- Feedback visual para loading e erros
- Fonte temática **Harry Potter (HarryP)**

---

## ▶️ Como executar

```bash
flutter pub get
flutter run
```

---

## 📌 Observações Finais

Este projeto foi desenvolvido com foco em:
- Qualidade de código
- Escalabilidade
- Boas práticas
- Experiência do usuário

Qualquer dúvida ou sugestão, fico à disposição.

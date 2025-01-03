# ChatBotUBot

### Estrutura com Duas APIs

1. **API Backend (Python com FastAPI)**:
   - Responsável pela lógica principal, como:
     - Processamento de mensagens.
     - Integração com o banco de dados PostgreSQL.
     - Chamadas para serviços de NLP (Processamento de Linguagem Natural).
   - Esta API é essencialmente o "cérebro" do sistema.

2. **API Frontend (Node.js com Vue.js)**:
   - Atua como um intermediário entre o frontend e o backend.
   - Funções típicas incluem:
     - Gerenciamento de autenticação.
     - Manipulação de dados para melhorar a experiência do usuário.
     - Chamadas para a API em Python e envio de respostas ao frontend.

---

### Comunicação entre as APIs

- **Frontend** (Vue.js) → **API Frontend** (Node.js):  
  O Vue.js se comunica com a API Node.js, que gerencia requisições do usuário.
  
- **API Frontend** (Node.js) → **API Backend** (Python):  
  A API Node.js envia dados para o backend em Python para processamento e recebe respostas, como mensagens processadas pelo chatbot.

---

### Benefícios de Duas APIs

1. **Separação de Responsabilidades**:
   - A lógica do chatbot fica isolada no backend Python.
   - A API em Node.js foca em lidar com o frontend.

2. **Escalabilidade**:
   - Cada API pode ser escalada de forma independente.
   - Se o backend Python for mais exigido, pode ser ampliado sem impactar o frontend.

3. **Flexibilidade Tecnológica**:
   - Você pode usar o que há de melhor em cada tecnologia para resolver problemas específicos.

4. **Desempenho**:
   - A API Node.js pode atuar como cache para certas respostas ou manipular dados antes de enviá-los ao frontend.

---

### Diagrama Simplificado

```plaintext
Vue.js (Frontend)
    |
    ↓
Node.js (API Frontend)
    |
    ↓
FastAPI (API Backend) ↔ PostgreSQL (Banco de Dados)
```

---

### Como Configurar?

#### 1. **API Frontend (Node.js)**

- Crie endpoints para o frontend chamar, como:

```typescript
app.post("/sendMessage", async (req, res) => {
  const { sessionId, message } = req.body;

  // Requisição para o backend (FastAPI)
  const response = await axios.post("http://localhost:8000/processMessage", {
    session_id: sessionId,
    message: message,
  });

  res.json(response.data);
});
```

#### 2. **API Backend (FastAPI)**

- Endpoint para processar mensagens:

```python
@app.post("/processMessage/")
def process_message(session_id: int, message: str, db: Session = Depends(get_db)):
    # Lógica do chatbot aqui
    bot_response = chatbot_logic(message)

    # Salvar no banco
    new_message = Message(session_id=session_id, sender="bot", message=bot_response)
    db.add(new_message)
    db.commit()

    return {"response": bot_response}
```

#### 3. **Frontend (Vue.js)**

- Chamando a API Node.js:

```typescript
const sendMessage = async (sessionId: number, message: string) => {
  const response = await axios.post("http://localhost:3000/sendMessage", {
    sessionId: sessionId,
    message: message,
  });
  console.log(response.data);
};
```

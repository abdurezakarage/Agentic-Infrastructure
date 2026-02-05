# Technical Specifications

## API Contracts

### Trend Data Structure
```json
{
  "trend_id": "uuid_v4",
  "topic": "string",
  "niche": "fashion|crypto|gaming|etc",
  "score": "float(0-1)",
  "volume": "integer",
  "sources": ["twitter", "news", "reddit"],
  "timestamp": "iso8601",
  "relevant_keywords": ["string"]
}
{
  "task_id": "uuid_v4",
  "task_type": "fetch_trends|generate_content|publish_post|execute_transaction",
  "priority": "high|medium|low",
  "context": {
    "goal_description": "string",
    "persona_constraints": ["string"],
    "required_resources": ["mcp://twitter/trends", "mcp://memory/recent"]
  },
  "created_at": "timestamp",
  "status": "pending|in_progress|review|complete"
}
// database
//  agents table
CREATE TABLE agents (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    soul_md_path TEXT,
    wallet_address VARCHAR(42),
    daily_spend_limit DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT NOW()
);

-- tasks table  
CREATE TABLE tasks (
    id UUID PRIMARY KEY,
    agent_id UUID REFERENCES agents(id),
    task_type VARCHAR(50),
    status VARCHAR(20),
    input_data JSONB,
    output_data JSONB,
    confidence_score FLOAT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- transactions table
CREATE TABLE transactions (
    id UUID PRIMARY KEY,
    agent_id UUID REFERENCES agents(id),
    amount DECIMAL(10,2),
    currency VARCHAR(10),
    to_address VARCHAR(42),
    status VARCHAR(20),
    signed_at TIMESTAMP
);
// MCP tool defination
{
  "name": "post_content",
  "description": "Publishes content to social platforms",
  "inputSchema": {
    "type": "object",
    "properties": {
      "platform": {"type": "string", "enum": ["twitter", "instagram", "tiktok"]},
      "text_content": {"type": "string"},
      "media_urls": {"type": "array", "items": {"type": "string"}},
      "ai_disclosure": {"type": "boolean", "default": true}
    },
    "required": ["platform", "text_content"]
  }
}

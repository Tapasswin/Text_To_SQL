import torch
from transformers import T5Tokenizer, T5ForConditionalGeneration
import datasets
from datasets import Dataset,load_metric
import pandas as pd
import tqdm
from transformers import DataCollatorForSeq2Seq, TrainingArguments, Trainer
# Load Module from local

model_dir = "D:/GIT/Train/models/t5-small-awesome-text-to-sql"

model_t5 = T5ForConditionalGeneration.from_pretrained(model_dir)
tokenizer = T5Tokenizer.from_pretrained(model_dir)

data = pd.read_csv("D:/GIT/Train/dataset.csv")
train_dataset = Dataset.from_dict(data)
test_dataset = Dataset.from_dict(data)
my_dataset_dict = datasets.DatasetDict({"train":train_dataset,"test":test_dataset})


# Tokenizing the data
def convert_data_to_tokens(data):
  input_encoder = tokenizer(data["question"], max_length=1024, truncation=True)

  with tokenizer.as_target_tokenizer():
    target_encoder = tokenizer(data["answer"], max_length=128, truncation=True)


  return {
      "input_ids": input_encoder["input_ids"],
      "attention_mask":input_encoder["attention_mask"],
      "labels":target_encoder["input_ids"]
  }

# Tokenizing the data by passing it in batches
dataset_pt = my_dataset_dict.map(convert_data_to_tokens, batched = True)

# Training

seq_2_seq_collator = DataCollatorForSeq2Seq(tokenizer, model = model_t5)

train_arg = TrainingArguments(
    output_dir="t5-small", num_train_epochs=2, warmup_steps=500,
    per_device_train_batch_size=1, per_device_eval_batch_size=1,
    weight_decay = 0.01, logging_steps=10,
    evaluation_strategy= 'steps', eval_steps=500, save_steps=1e6,
    gradient_accumulation_steps=16, learning_rate = 0.00001
)

trainer = Trainer(
    model = model_t5, args = train_arg,
    tokenizer = tokenizer, data_collator = seq_2_seq_collator,
    train_dataset= dataset_pt["train"],
    eval_dataset= dataset_pt["test"]
)
trainer.train()

# Save Model
model_t5.save_pretrained("trained-model")

# Save Tokenizer
tokenizer.save_pretrained("trained-tokenizer")
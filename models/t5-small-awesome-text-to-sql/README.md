---
license: apache-2.0
datasets:
- Clinton/Text-to-sql-v1
- b-mc2/sql-create-context
language:
- en
pipeline_tag: text2text-generation
---
# Model Card for Model ID

<!-- Based on  https://huggingface.co/t5-small, model generates SQL from text given table list with "CREATE TABLE" statements. 
This is a very light weigh model and could be used in multiple analytical applications. -->

Based on  [t5-small](https://huggingface.co/t5-small), model generates SQL from text given table list with "CREATE TABLE" statements. Supports multiple tables with joins. 
This is a very light weigh model and could be used in multiple analytical applications. Used combination of [b-mc2/sql-create-context](https://huggingface.co/datasets/b-mc2/sql-create-context) and [Clinton/Text-to-sql-v1](https://huggingface.co/datasets/Clinton/Text-to-sql-v1) dataset.
Contact us for more info: support@cloudsummary.com


## Model Details

### Model Description

<!-- Provide a longer summary of what this model is. -->



- **Developed by:** cssupport (support@cloudsummary.com)
- **Model type:** Language model
- **Language(s) (NLP):** English
- **License:** Apache 2.0
- **Finetuned from model :** [t5-small](https://huggingface.co/t5-small)

### Model Sources 

<!-- Provide the basic links for the model. -->

Please refer [t5-small](https://huggingface.co/t5-small) for Model Sources.

## How to Get Started with the Model

Use the code below to get started with the model.

```python
import torch
from transformers import T5Tokenizer, T5ForConditionalGeneration

# Initialize the tokenizer from Hugging Face Transformers library
tokenizer = T5Tokenizer.from_pretrained('t5-small')

# Load the model
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = T5ForConditionalGeneration.from_pretrained('cssupport/t5-small-awesome-text-to-sql')
model = model.to(device)
model.eval()

def generate_sql(input_prompt):
    # Tokenize the input prompt
    inputs = tokenizer(input_prompt, padding=True, truncation=True, return_tensors="pt").to(device)
    
    # Forward pass
    with torch.no_grad():
        outputs = model.generate(**inputs, max_length=512)
    
    # Decode the output IDs to a string (SQL query in this case)
    generated_sql = tokenizer.decode(outputs[0], skip_special_tokens=True)
    
    return generated_sql

# Test the function
#input_prompt = "tables:\n" + "CREATE TABLE Catalogs (date_of_latest_revision VARCHAR)" + "\n" +"query for: Find the dates on which more than one revisions were made."
#input_prompt = "tables:\n" + "CREATE TABLE table_22767 ( \"Year\" real, \"World\" real, \"Asia\" text, \"Africa\" text, \"Europe\" text, \"Latin America/Caribbean\" text, \"Northern America\" text, \"Oceania\" text )" + "\n" +"query for:what will the population of Asia be when Latin America/Caribbean is 783 (7.5%)?."
#input_prompt = "tables:\n" + "CREATE TABLE procedures ( subject_id text, hadm_id text, icd9_code text, short_title text, long_title text ) CREATE TABLE diagnoses ( subject_id text, hadm_id text, icd9_code text, short_title text, long_title text ) CREATE TABLE lab ( subject_id text, hadm_id text, itemid text, charttime text, flag text, value_unit text, label text, fluid text ) CREATE TABLE demographic ( subject_id text, hadm_id text, name text, marital_status text, age text, dob text, gender text, language text, religion text, admission_type text, days_stay text, insurance text, ethnicity text, expire_flag text, admission_location text, discharge_location text, diagnosis text, dod text, dob_year text, dod_year text, admittime text, dischtime text, admityear text ) CREATE TABLE prescriptions ( subject_id text, hadm_id text, icustay_id text, drug_type text, drug text, formulary_drug_cd text, route text, drug_dose text )" + "\n" +"query for:" + "what is the total number of patients who were diagnosed with icd9 code 2254?"
input_prompt = "tables:\n" + "CREATE TABLE student_course_attendance (student_id VARCHAR); CREATE TABLE students (student_id VARCHAR)" + "\n" + "query for:" + "List the id of students who never attends courses?"

generated_sql = generate_sql(input_prompt)

print(f"The generated SQL query is: {generated_sql}")
#OUTPUT: The generated SQL query is: SELECT student_id FROM students WHERE NOT student_id IN (SELECT student_id FROM student_course_attendance)

```


## Uses

<!-- Address questions around how the model is intended to be used, including the foreseeable users of the model and those affected by the model. -->

[More Information Needed]

### Direct Use

<!-- This section is for the model use without fine-tuning or plugging into a larger ecosystem/app. -->
Could used in application where natural language is to be converted into SQL queries. 
[More Information Needed]



### Out-of-Scope Use

<!-- This section addresses misuse, malicious use, and uses that the model will not work well for. -->

[More Information Needed]

## Bias, Risks, and Limitations

<!-- This section is meant to convey both technical and sociotechnical limitations. -->

[More Information Needed]

### Recommendations

<!-- This section is meant to convey recommendations with respect to the bias, risk, and technical limitations. -->

Users (both direct and downstream) should be made aware of the risks, biases and limitations of the model. More information needed for further recommendations.



## Technical Specifications 

### Model Architecture and Objective

[t5-small](https://huggingface.co/t5-small)

### Compute Infrastructure



#### Hardware

one A100-80

#### Software

Pytorch and HuggingFace 


## Model Card Contact

cssupport (support@cloudsummary.com)
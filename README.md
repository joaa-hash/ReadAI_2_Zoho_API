<a name="readme-top"></a>

<div align="center">
  <h3><b>README</b></h3>
</div>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
  - [Deployment](#deployment)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [❓ FAQ (OPTIONAL)](#faq)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 ReadAI 2 Zoho API <a name="about-project"></a>

> What is this?

**ReadAI 2 Zoho** is an API designed to connect Read AI to Zoho CRM, it works by recieven a webhook submitted by Read AI, parse the incomming data and format it to send it to Zoho CRM. It use a refresh_token that is added as an enviromental file, and then it is used to get an acces token on each request.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Connected Services</summary>
  <ul>
    <li><a href="https://crmplus.zoho.com/">Zoho CRM</a></li>
    <li><a href="https://www.read.ai/">Read AI</a></li>
  </ul>
</details>

<details>
  <summary>API Connection</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby On Rails 7.2.0</a></li>
    <li><a href="https://rubyonrails.org/">Ruby 3.2.2</a></li>
    <li><a href="https://github.com/jnunemaker/httparty">HTTParty</a></li>
    <li><a href="https://github.com/bkeepers/dotenv">dotenv-rails</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

- **Receives Meeting Data from a ReadAI webhook**
- **Performs an Oauth token connection with Zoho CRM**
- **Redirects meeting data to Zoho CRM**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:
- Zoho CRM Account with premium features and a module to store Read Ai data.
    1. Create a module to store incoming data from Read Ai, such, name it as you wish, for example `Read AI meetings`, you can do it in [Zoho CRM add module option](https://crmplus.zoho.com/test6295/index.do/cxapp/crm/org860067954/settings/modules/create)
    2. Add required fields for the module layout:
        - start_time as Date/Time.
        - end_time as Date/Time.
        - summary as Multi-Line.
        - report_url as URL.
        - session_id as Single Line.
        - Participants as Subform with name and Email.

         Note: if you need it, you can access to [Modules and Fields](https://crmplus.zoho.com/test6295/index.do/cxapp/crm/org860067954/settings/modules) to modify any module layout.
    3. Click on `Save and Close` to store the module layout.
    
    - If necesary to debug a connection, it might be helpul to check the Zoho CRM [Api names](https://crmplus.zoho.com/test6295/index.do/cxapp/crm/org860067954/settings/api/modules).

- Read AI Account with premium features.
    - Go to [Webhooks](https://app.read.ai/analytics/integrations/user/workflow/webhooks) and click on `Add webhook`.
    - Add the base URL were the APi is deployed + the end point `/meetings/new`, example: `https://readai-2-zoho-api.onrender.com/meetings/new`
    - Click on `Save Changes`.

### Setup

Clone this repository to your desired folder:
```sh
cd my-folder
```
proceed to clone:

```sh
git clone git@github.com:Diegogagan2587/ReadAI_2_Zoho_API.git
```

### Install

Install this project with:

```sh
bundle install
```

### Usage

#### Add Enviromental variables
 
 - If you are in development enviroment, please create a `.env` in the root of the project with the following data:
 ```.env
ZOHO_CLIENT_ID=MY_ZOHO_CLIENT
ZOHO_CLIENT_SECRET=MY_CLIENT_SECRET
ZOHO_REFRESH_TOKEN=MY_REFRESH_TOKEN

 ``` 

 If you are in production please follow your hosting documentations to provide the this enviromental variables.


#### Execute it

To run the project, execute the following command:

```sh
  rails server
```

#### Proceed with POSTMAN
In development you can play around with the API using Postman, remember to access Read AI [Getting STarted Wtih Webhooks](https://support.read.ai/hc/en-us/articles/16352415827219-Integrations-Getting-Started-with-Webhooks) to see what should be the Json structure. 
<!--
### Run tests

To run tests, run the following command:


Example command:

```sh
  bin/rails test test/models/article_test.rb
```
--->

### Deployment

This API can be deploy on multiple services, a service that I prefer is render, if you like to use this service you can deploy following this Render article [Deploying Ruby on Rails on Render](https://docs.render.com/deploy-rails)

Once the Application is Deployed, please add the `https://base-url.com/meetings/new` end point into your weebhook in Read Ai to start the connection. See prerequistes for info about Read Ai and Zoho CRM.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

👤 **Diego Vidal Lopez**

- GitHub: [@Diegogagan2587](https://github.com/Diegogagan2587)
- LinkedIn: [Diego Vidal](https://www.linkedin.com/in/diego-vidal-lopez/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>
> Below some fields would be great to connect in the future.

- [ ] **action items**
- [ ] **key questions**
- [ ] **topics**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Diegogagan2587/ReadAI_2_Zoho_API/issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional) -->

## ❓ FAQ (OPTIONAL) <a name="faq"></a>

> Add at least 2 questions new developers would ask when they decide to use your project.

- **What is the data tha Read AI can submit using the webhook?**

  - You cand consult the [Schema](https://support.read.ai/hc/en-us/articles/16352415827219-Integrations-Getting-Started-with-Webhooks#:~:text=update%20to%20%22Active%22.-,Schema,-Webhook%20Trigger%20and) and find all available data coming from Read Ai.

- **How do I know wich data does ZohoCRM does accept?**

  - You can consult the Zoho CRM article [Insert Records](https://www.zoho.com/crm/developer/docs/api/v7/insert-records.html) to know wich data tipes are accepted by the Zoho CRM API, additinaly you can see the End-Points for each specificif modules in the [Api Names](https://crmplus.zoho.com/test6295/index.do/cxapp/crm/org860067954/settings/api/modules) section, if you click in any module, you will see the name of each field as well.

- **How do I get the refresh Token?**

  1. Go to the [Zoho Developer Console], Create a `Self Client` or re-use any existing one, Then Open the `Self Client` Introduce a [Zoho Scope](https://www.zoho.com/crm/developer/docs/api/v3/scopes.html), select your desired time duration, add your selected scope description, Select `CRM`, then select the option you want(Production, Test, etc), then click on create, and copy the provided code, remember ti will expired in the previously selected time.
  2. Consult the [API collection](https://www.zoho.com/crm/developer/docs/api/v7/api-collection.html), Fork the provided collection in Postman, re-use the provided endpoints by following the instructions in the article [Authorization Request](https://www.zoho.com/crm/developer/docs/api/v7/auth-request.html), then you should be able to get the refresh token.
 - **Is there any Ruby SDK (software developer kit) ?**
 - Yes, there is and we will explore it further in the future, learn more in [Ruby SDK for Zoho CRM APIs](https://www.zoho.com/crm/developer/docs/sdk/server-side/ruby-sdk.html)

 - **Where do I find more Zoho CRM Developer resources?**
 - in [Help Develper](https://www.zoho.com/crm/help/developer/?src=zcp_rsc)



<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

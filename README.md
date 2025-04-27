
# 🔍 SubWatch – Automated Subdomain Monitoring Script

**SubWatch** is a lightweight Bash script designed to continuously monitor your target domains for newly discovered subdomains. Built for bug bounty hunters, recon specialists, and automation lovers, it leverages powerful tools like `subfinder`, `anew`, and `notify` to keep your recon updated — and sends alerts directly to your Discord.

---

## 📌 Features

- ⏱️ Runs automatically every 6 hours
- 🧠 Tracks and stores unique subdomains per target
- 📨 Sends new subdomains as file attachments to Discord
- ⚙️ Uses `subfinder`, `anew`, `notify`, and `jq`
- ✅ Simple, lightweight, and effective for long-term monitoring

---

## 🛠 Requirements

Make sure the following tools are installed and available in your `$PATH`:

- [`subfinder`](https://github.com/projectdiscovery/subfinder)
- [`anew`](https://github.com/tomnomnom/anew)
- [`notify`](https://github.com/projectdiscovery/notify)
- [`jq`](https://stedolan.github.io/jq/)

### Installation Example:

```bash
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/projectdiscovery/notify/cmd/notify@latest
sudo apt install jq
```

> Make sure `$GOPATH/bin` is in your `$PATH`.

---

## ⚙️ Setup

1. **Clone the Repository**

```bash
git clone https://github.com/yourusername/subwatch.git
cd subwatch
```

2. **Prepare Your Domain List**

Create a `domains.txt` file in the same directory.  
Each line should contain a single root domain:

```
example.com
testsite.org
```

3. **Configure Discord Webhook with Notify**

Set up your `notify` config:

```bash
notify -config
```

Then add your Discord webhook as a provider and give it the ID `subdomains`.

4. **Make the Script Executable**

```bash
chmod +x subwatch.sh
```

---

## 🚀 Usage

To run the script:

```bash
./subwatch.sh
```

> The script runs in an infinite loop, checking for new subdomains every 6 hours and notifying only when new entries are found.

![Watch the video](poc.gif)

---

## 📂 Output

- Subdomains are saved in individual files:  
  `example.com-list.txt`, `testsite.org-list.txt`, etc.
- New findings (if any) are sent as `.txt` file attachments to your Discord webhook using `notify`.

---

## 🧠 Example Notification Format

> 🚨 New subdomains detected for `example.com` (5):  
> See attached `.txt` file.

![Watch the video](poc.png)

---

## 📣 Credits

Made with ❤️ by [**Brut Security**](https://brutsec.com)  
Join us for practical cybersecurity training, tools, and community.

- 🌐 [brutsec.com](https://brutsec.com)  
- 🐦 [Twitter](https://x.com/brutsecurity)  
- 💼 [LinkedIn](https://www.linkedin.com/company/brutsec/)  
- 📱 [Telegram](https://t.me/BrutSecurity)  
- 📧 info@brutsec.com

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.  

const backendURL = "http://localhost:5000";

document.getElementById("generate").addEventListener("click", async () => {
  const name = document.getElementById("recipient").value.trim();
  const file = document.getElementById("resume").files[0];

  if (!name || !file) return alert("Enter a name and upload a resume");

  const formData = new FormData();
  formData.append("recipient", name);
  formData.append("resume", file);

  try {
    const res = await fetch(`${backendURL}/upload`, {
      method: "POST",
      body: formData,
    });
    const data = await res.json();

    if (data.success) {
      const trackURL = `${backendURL}/track/${encodeURIComponent(name)}`;
      navigator.clipboard.writeText(trackURL);
      document.getElementById("output").textContent = `Link copied: ${trackURL}`;
    } else {
      alert("Upload failed");
    }
  } catch (err) {
    console.error(err);
    alert("Error uploading resume");
  }
});

// Open the dashboard page
document.getElementById("openDashboard").addEventListener("click", function() {
    chrome.tabs.create({ url: "http://localhost:5000/dashboard.html" });
  });

 
  
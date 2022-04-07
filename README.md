  <div id="top"></div>

[![Contributors][contributors-shield]](https://github.com/franckferman/hyper-v_toolbox/graphs/contributors)
[![Forks][forks-shield]](https://github.com/franckferman/hyper-v_toolbox/network/members)
[![Stargazers][stars-shield]](https://github.com/franckferman/hyper-v_toolbox/stargazers)
[![Issues][issues-shield]](https://github.com/franckferman/hyper-v_toolbox/issues)
[![MIT License][license-shield]](https://github.com/franckferman/hyper-v_toolbox/blob/main/LICENSE)

<br />
<div align="center">
  <a href="https://github.com/franckferman/hyper-v_toolbox">
    <img src="https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/img/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">hyper-v_toolbox</h3>

  <p align="center">
    Hyper-V Toolbox is a PowerShell script allowing advanced manipulation of Hyper-V from your terminal.
    <br />
    <a href="https://github.com/franckferman/hyper-v_toolbox"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/franckferman/hyper-v_toolbox/issues">Report Bug</a>
    ·
    <a href="https://github.com/franckferman/hyper-v_toolbox/issues">Request Feature</a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#tested-on">Tested on</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

I didn't reinvent the wheel with this project however, it can lead to a considerable time saving for people having a regular use of Hyper-V. Whether you are a technician, an administrator, a student, a teacher or even just a computer enthusiast and you need to use Hyper-V, this tool will save you a lot of time.

The principle of this tool is simple, it is a complete interactive script (with choice) allowing the advanced management of Hyper-V.

Here is an overview of the available features:

- Creation of virtual machines.

It's very easy and fast, you just have to answer the questions asked by the script.

Before each machine creation, the script will check if the desired resources are present or not and will make a choice accordingly. If it does not find the resources and the desired tree, it will automatically download the iso corresponding to the selected machine, and create the specific tree for the storage of the resources if, once again, they are not already present.

At the moment, the tool already allows the creation of multiple systems: Microsoft Windows (Microsoft Windows 10 Pro, Enterprise, Server 2012, 2019), GNU/Linux (Debian, pfSense, Parrot Security, Rocky Linux, Kali Linux)...

Being on Github, don't forget that, anyone who wants to participate in the project can join me and add the resources he wants.

- The creation of preconfigured virtual machines.

The idea will be to create a virtual machine with already filled parameters, taking over an already existing hard disk and to summarize, the user will arrive on a machine already ready to use.

How can we do this? Let's take the example of a Windows 10 Enterprise machine: I made a sysprep on the machine to which I linked a response file (autounattend.xml) allowing me to pass all the "long" and "annoying" steps of the Windows OOBE (acceptance of the terms of use, setting of Windows privacy options, creation of a local account ...), in the end the user arrives on a blank Windows desktop, already ready to work.

- Virtual machine management

Classic tasks such as, list machines, turn on one (or more) machine, turn on all machines, turn off one (or more) machine, turn off all machines, delete one (or more) machine, delete all machines...

- Virtual switch management.

List, create, delete virtual switches...

- A resource management system

When you create a machine, the script will check in the files if it finds the corresponding resource, if it doesn't find it, it will go and download it (before that, check the existence of the tree I was talking about and create it if it doesn't exist) and then continue.

So I thought it would be interesting to make a resource management system that downloads the necessary resources in advance.

You can choose to download all the resources, or only those for Windows machines, or only those for Linux, and better still, I made a "customization" function allowing you to choose in detail what you need or not.

<p align="right">(<a href="#top">back to top</a>)</p>

### Tested On

The script has been tested and tests have been performed on these system and software versions:
* - [x] [Microsoft Windows 11 Pro](https://www.microsoft.com/en-us/windows/get-windows-11)
* - [x] [Microsoft Windows 10 Pro](https://www.microsoft.com/en-us/d/windows-10-pro/df77x4d43rkt?activetab=pivot:overviewtab)
* - [x] [Microsoft Windows PowerShell 5.1.22000.282](https://microsoft.com/powershell)
* - [x] [Microsoft Windows PowerShell 7.2.2](https://microsoft.com/powershell)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

This course is not intended to teach you how to use PowerShell. However, I will simply show you (for beginners) how to easily download my script with PowerShell and run it.

I don't think a tutorial would be very useful to teach you how to use the script as it was designed to be naturally intuitive, you should be able to find your way around quite easily.

### Prerequisites

Please note that my script must be placed where you want your machines to be stored.

* For example, if you want them to be in your C:\ directory, issue the following command from your PowerShell terminal:
```sh
Start-BitsTransfer -Source https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/hyper-v_toolbox.ps1 -Destination "C:\" -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Downloading the script."
```

Of course, you can change the desired destination path. To do this, you just have to change the argument of the -Destination parameter.

* For example:
```sh
Start-BitsTransfer -Source https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/hyper-v_toolbox.ps1 -Destination "D:\Your_Custom_Path" -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Downloading the script."
```

<!-- USAGE EXAMPLES -->
## Usage

* To run the script, simply go to the script installation path and run the PowerShell script (Administrator rights are required):
```sh
Set-Location -Path "C:\";Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass;.\hyper-v_toolbox.ps1
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Project Link: [https://github.com/franckferman/hyper-v_toolbox](https://github.com/franckferman/hyper-v_toolbox)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/franckferman/hyper-v_toolbox.svg?style=for-the-badge
[contributors-url]: https://github.com/franckferman/hyper-v_toolbox/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/franckferman/hyper-v_toolbox.svg?style=for-the-badge
[forks-url]: https://github.com/franckferman/hyper-v_toolbox/network/members
[stars-shield]: https://img.shields.io/github/stars/franckferman/hyper-v_toolbox.svg?style=for-the-badge
[stars-url]: https://github.com/franckferman/hyper-v_toolbox/stargazers
[issues-shield]: https://img.shields.io/github/issues/franckferman/hyper-v_toolbox.svg?style=for-the-badge
[issues-url]: https://github.com/franckferman/hyper-v_toolbox/issues
[license-shield]: https://img.shields.io/github/license/franckferman/hyper-v_toolbox.svg?style=for-the-badge
[license-url]: https://github.com/franckferman/hyper-v_toolbox/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/fferman42
[product-screenshot]: images/screenshot.png

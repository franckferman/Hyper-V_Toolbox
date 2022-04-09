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
    <a href="https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/misc/full_documentation-hyper-v_toolbox.docx"><strong>Explore the docs »</strong></a>
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

<br />
<div align="center">
  <a href="#">
    <img src="https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/img/Hyper-V_Toolbox-Main_Picture.png" alt="Hyper-V_Toolbox-Main_Picture" width="350" height="450">
  </a>
</div><br /><br />

The goal of this project is not to reinvent the wheel. But to my knowledge, no similar tool of this type as complete existed on Github before this one.

The ultimate interest of this project as a whole is to save time and to improve the comfort of use considerably. Whether you are a technician, an administrator, a student, a teacher or even just a computer enthusiast wishing to use Hyper-V for your various projects, this tool will be an undeniable ally.

The principle of Hyper-V Toolbox is simple. It is an interactive script (with multiple choices adapting to the user's answers) strongly user-friendly and allowing (among other things) the management and advanced manipulation of Hyper-V from your terminal.

For more information and illustrations »<a href="https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/misc/full_documentation-hyper-v_toolbox.docx"><strong>Explore the full documentation</strong></a>.

<br />Here is an overview of the available features:

<br />

- Creation of (basic) virtual machines.

It is very simple, fast and effective. You just have to answer the questions asked by the script.

Many choices of systems are offered to you for the creation of your virtual machine. In order not to lose the user and to keep a coherent, orderly and harmonious structure, I have grouped the systems by separating them into two distinct categories: Microsoft Windows on one side and GNU/Linux on the other.

After selecting the desired system, two basic questions are asked by the script, the choice of a name for your machine and the possibility or not to choose a network card.
Then, in a first step, the script checks if the tree structure initially created by the script is present or not, if not, takes care of it accordingly. 

In a second step, the script checks if the desired resources are present or not. By resources, I mean everything that the machine will need to be correctly created and used. In this case, when creating simple virtual machines, it will most often just be an ISO image. If the resource(s) are not identified in the tree, the download will run by itself to complete the creation of the machine.

Some other basic questions (for the good continuity of the creation of the machine) are asked such as the choice of the quantity of RAM or the size of the hard disk desired for the machine.

Once the machine has been created, which is generally extremely fast (a few seconds at best), several choices are available to you, two of which are particularly interesting. You can quickly create the same type of machine with different characteristics or recreate the same type of machine with the same characteristics.

To take a concrete example, in the context of practical work in class, or even for professional demonstrations or numerous tests for system administration or computer security, we sometimes need to create two machines of the same type such as two Windows Servers, two Windows 10 (clients). This function allows the preparation of these elements in just a few seconds.

By default, the script optimizes the virtual machine parameters to allow the user to have a machine already ready to use. At least, to allow him to limit as much as possible the actions to perform. 

For example, the automatic restore points are disabled and the boot order is also modified so that the user does not have to modify anything.

On Linux, secure boot is disabled and dynamic RAM management is disabled because it is often poorly managed by Hyper-V.

The tool already handles the creation of many systems such as Microsoft Windows systems including Windows 10 pro, enterprise, server 2012, and 2019 but also many GNU/Linux systems such as pfSense, Debian, Parrot Security, Rocky Linux (with two editions available) and Kali Linux (also with two editions available).

Most of the ISOs have been retrieved from official repositories. This is not the case for PfSense, since the download from the official repository retrieves a compressed image. 

PowerShell handles well the Expand-Archive command which allows extraction of compressed files but does not handle decompression of compressed .gz files.

For this reason, I simply hosted on some of my rented servers the PfSense iso. Although, in the long run, I would greatly appreciate help from the school to keep the costs as low as possible.

The Microsoft Windows systems ISOs (10 pro, enterprise, server 2012 and 2019) were also hosted on my servers.

<br />

- Creation of preconfigured virtual machines.

This function is still in preparation.

Just like the (basic) virtual machine creation function, the user will be asked some basic questions. With a few notable differences, at first, some choices will allow you to further speed up the creation process as only the name and network card of the desired machine will be asked.

The RAM will be automatically adjusted according to the desired machine, and the hard disk? This is where it gets interesting.

A differentiation disk will be created from the parent disk corresponding to the desired machine. What's the point? What does this famous parent hard disk contain? It all depends on the desired machine. But we will take the example of a Windows 10 client.

After having performed various manipulations on the machine (software installations that could be useful, system settings, etc.), I made a sysprep on the machine, sysprep to which we can link a response file (autounattend.xml). What I did, and what will allow, at the startup of the machine to pass all the "long" and "boring" steps of the Windows OOBE a.k.a. Out-of-box experience (acceptance of the terms of use, setting of the Windows privacy options, creation of a local account etc.) and at the end, the goal for the user will be to arrive on a Windows desktop, connected to a local account, already ready to use.

<br />

- Virtual switch management.

This feature is just a plus for management support, it simply allows (non-advanced) management of virtual switches. More precisely, it allows to display, create and delete virtual switches.

<br />

- Virtual machines management.

Just like the virtual switch management, these are basic functions (although this time much more useful and offering some additional features) allowing the manipulation of Hyper-V machines. By manipulation I mean all sorts of classic but useful tasks, such as: displaying the list of virtual machines and their status. Starting one, several, or all the machines. Shutting down one, several, or all machines. The deletion of one, several, or all the machines. In short, a relatively classical management of virtual machines.

<br />

- An advanced resource management system.

As seen before, before each virtual machine creation, the script checks if the tree structure has been initially created by the script and acts accordingly then checks if the desired resources are present or not and takes care of downloading them if needed.

As a result, this first download might take some time although once it has been downloaded once, it will be present and available for the next times.
So I thought it would be interesting to set up a resource management system that downloads the desired needed resources in advance. 

There are multiple possibilities: downloading resources for the creation of Microsoft Windows virtual machines only, downloading resources for the creation of GNU/Linux virtual machines only, the possibility to download absolutely all resources, and one last solution that I strongly recommend, I have made a customization function, by customization I mean a certain form of interactivity, which will allow the user to choose precisely and only the resources that he will really need.

<p align="right">(<a href="#top">back to top</a>)</p>

### Tested On

The script has been tested on different versions of Microsoft Windows and PowerShell:
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

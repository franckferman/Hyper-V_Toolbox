  <div id="top"></div>

[![Contributors][contributors-shield]](https://github.com/franckferman/hyper-v_toolbox/graphs/contributors)
[![Forks][forks-shield]](https://github.com/franckferman/hyper-v_toolbox/network/members)
[![Stargazers][stars-shield]](https://github.com/franckferman/hyper-v_toolbox/stargazers)
[![Issues][issues-shield]](https://github.com/franckferman/hyper-v_toolbox/issues)
[![MIT License][license-shield]](https://github.com/franckferman/hyper-v_toolbox/blob/main/LICENSE)
[![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/fferman42)

<br />
<div align="center">
  <a href="https://github.com/franckferman/hyper-v_toolbox">
    <img src="https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/img/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">hyper-v_toolbox</h3>

  <p align="center">
    Hyper-V Toolbox is a PowerShell script allowing (among other things) the complete (and advanced) management of virtual machines (with Hyper V).
    <br />
    <a href="https://github.com/franckferman/fix_wsl2_networking"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://asciinema.org/a/C3OT7oVZOARXTUUISkpgdfIDm">View Demo</a>
    ·
    <a href="https://github.com/franckferman/fix_wsl2_networking/issues">Report Bug</a>
    ·
    <a href="https://github.com/franckferman/fix_wsl2_networking/issues">Request Feature</a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
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

This project was done for many reasons but the main reason was to improve, should I say find a solution to make the process of creating virtual machines in the learning environment much faster.

This script does not stop at simply creating a virtual machine. The goal is to really save time and improve the different processes of creation and preparation of the numerous labs and parameters.

The script proposes:

- The creation of "blank" virtual machines. Only the name, RAM, etc. (the essential parameters) are required, and the biggest advantage is that the script automatically fetches the corresponding ISO.

- The creation of machines from "models". For example, if you need a Windows Server machine, the script will provide you with a pre-installed machine to optimize your time.

- Virtual machine management, launch, shutdown, etc.

- Virtual switch management, creation, deletion...

- A resource management (ISO), you can decide to download all available ISOs to be ready for installation without having any waiting time.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With and Tested On

Here are the different tools that I used to create my script and performed my tests.

Build With and On :
* [Microsoft Windows 11 Pro](https://www.microsoft.com/en-us/windows/get-windows-11)
* [Microsoft Windows 10 Pro](https://www.microsoft.com/en-us/d/windows-10-pro/df77x4d43rkt?activetab=pivot:overviewtab)

Tested On :
* - [x] [Microsoft Windows 11 Pro](https://www.microsoft.com/en-us/windows/get-windows-11)
* - [] [Microsoft Windows 10 Pro](https://www.microsoft.com/en-us/d/windows-10-pro/df77x4d43rkt?activetab=pivot:overviewtab)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

This document is currently being written.

### Prerequisites

This document is currently being written.

* From PowerShell
```sh
Start-BitsTransfer -Source https://raw.githubusercontent.com/franckferman/hyper-v_toolbox/main/hyper-v_toolbox.ps1 -Destination C:\
```

<!-- USAGE EXAMPLES -->
## Usage

To run the script, you just need to use the following command.
```sh
.\hyper-v_toolbox.ps1
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

Franck FERMAN - [LinkedIn](https://www.linkedin.com/in/fferman42) - fferman@protonmail.ch

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

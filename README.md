<div align="center">
<h1> HuSc3D: Human Sculpture dataset for 3D object reconstruction</h1>
Weronika Smolak-Dyżewska, Dawid Malarz, Grzegorz Wilczyński, Rafał Tobiasz, Joanna Waczyńska, Piotr Borycki, Przemysław Spurek
<br> <br>


[![arXiv](https://img.shields.io/badge/arXiv-2506.07628-red)](https://arxiv.org/abs/2506.07628)  [![ProjectPage](https://img.shields.io/badge/Website-wmito.github.io/HuSc3D-blue)](https://wmito.github.io/HuSc3D/) [![GitHub Repo stars](https://img.shields.io/github/stars/wmito/HuSc3D.svg?style=social&label=Star&maxAge=60)](https://github.com/wMito/HuSc3D)

</div>

<img src="./assets/teaser.jpg" />

This repository contains the code for evaluation made for benchmarking with HuSc3D dataset.
Link to dataset: https://huggingface.co/datasets/rafal-tobiasz/HuSc3D

<img src="./assets/jaroslaw.gif" width=50% />
<img src="./assets/wiktor.gif" width=50% />

**Abstract:** 3D scene reconstruction from 2D images is one of the most important tasks in computer graphics. Unfortunately, existing datasets and benchmarks concentrate on idealized synthetic or meticulously captured realistic data. Such benchmarks fail to convey the inherent complexities encountered in newly acquired real-world scenes. In such scenes especially those acquired outside, the background is often dynamic, and by popular usage of cell phone cameras, there might be discrepancies in, e.g., white balance.

To address this gap, we present HuSc3D, a novel dataset specifically designed for rigorous benchmarking of 3D reconstruction models under realistic acquisition challenges. Our dataset uniquely features six highly detailed, fully white sculptures characterized by intricate perforations and minimal textural and color variation. Furthermore, the number of images per scene varies significantly, introducing the additional challenge of limited training data for some instances alongside scenes with a standard number of views. By evaluating popular 3D reconstruction methods on this diverse dataset, we demonstrate the distinctiveness of HuSc3D in effectively differentiating model performance, particularly highlighting the sensitivity of methods to fine geometric details, color ambiguity, and varying data availability – limitations often masked by more conventional datasets.



<section class="section" id="BibTeX">
  <div class="container is-max-desktop content">
    <h2 class="title">Citations</h2>
If you find our work useful, please consider citing:
    <pre><code>@Article{smolakdyzewska2025husc3d,
      title={HuSc3D: Human Sculpture dataset for 3D object reconstruction}, 
      author={Weronika Smolak-Dyżewska and Dawid Malarz and Grzegorz Wilczyński and Rafał Tobiasz and Joanna Waczyńska and Piotr Borycki and Przemysław Spurek},
      year={2025},
      eprint={2506.07628},
      archivePrefix={arXiv},
      primaryClass={cs.CV},
      url={https://arxiv.org/abs/2506.07628}, 
    }
</code></pre>

</div>

</section>

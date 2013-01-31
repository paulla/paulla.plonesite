import os, sys

from setuptools import setup, find_packages

version = "1.0dev"

def read(*rnames):
    return open(
        os.path.join('.', *rnames)
    ).read()

long_description = "\n\n".join(
    [read('README.rst'),
     read('docs', 'INSTALL.rst'),
     read('docs', 'CHANGES.rst'),
    ]
)

classifiers = [
    "Framework :: Plone",
    "Framework :: Plone :: 4.0",
    "Framework :: Plone :: 4.1",
    "Framework :: Plone :: 4.2",
    "Programming Language :: Python",
    "Topic :: Software Development",]

name = 'paulla.plonesite'
setup(
    name=name,
    namespace_packages=[         'paulla',    ],
    version=version,
    description='Project PauLLA',
    long_description=long_description,
    classifiers=classifiers,
    keywords='',
    author='jpc <jp.camguilhem@gmail.com>',
    author_email='jp.camguilhem@gmail.com',
    url='http://www.generic.com',
    license='BSD',
    packages=find_packages('src'),
    package_dir = {'': 'src'},
    include_package_data=True,
    install_requires=[
        'setuptools',
        'z3c.autoinclude',
        'Plone',
        'plone.app.upgrade',
        # with_ploneproduct_awspdfbook
        'aws.pdfbook',
        # with_ploneproduct_ldap
        'python-ldap',
        'bda.ldap',
        'Products.LDAPMultiPlugins',
        'Products.LDAPUserFolder',
        'Products.PloneLDAP',
        'plone.app.ldap',
        # with_ploneproduct_addthis
        'collective.addthis',
        # with_ploneproduct_cjsleaflet
        'collective.js.leaflet',
        # with_ploneproduct_enewsletter
        'Products.EasyNewsletter',
        # with_ploneproduct_patheming
        'plone.app.theming',
        'plone.app.themingplugins',
        # -*- Extra requirements: -*-
    ],
    extras_require = {
        'test': ['plone.app.testing', 'ipython',]
    },
    entry_points = {
        'z3c.autoinclude.plugin': ['target = plone',],
    },
)
# vim:set ft=python:

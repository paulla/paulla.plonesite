import logging
from zope.i18nmessageid import MessageFactory
MessageFactory = paullaplonesiteMessageFactory = MessageFactory('paulla.plonesite') 
logger = logging.getLogger('paulla.plonesite')
def initialize(context):
    """Initializer called when used as a Zope 2 product.""" 

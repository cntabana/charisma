<?php
 

$widget = $this->widget('bootstrap.widgets.TbListView', array(
    'id'           => 'listview',
    'dataProvider' => $dataProvider,
    'itemView'     => '_analyseDemande',
));
 
//for update editables after ajax sort and pagination
Editable::attachAjaxUpdateEvent($widget); 
?>


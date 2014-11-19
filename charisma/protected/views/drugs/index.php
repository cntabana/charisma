<?php
$model = new Drugs;
$this->breadcrumbs=array(
  'Drugs',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
    $('.search-form').slideToggle('fast');
    return false;
});
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('drugs-grid', {
        data: $(this).serialize()
    });
    return false;
});
");

?>

<h3>Pharmacy</h3>
<hr />

<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
  'htmlOptions'=>array(
    'class'=>''
  )
));
$this->widget('bootstrap.widgets.TbMenu', array(
  'type'=>'pills',
  'items'=>array(
    array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array()),
    array('label'=>'Admin', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'active'=>true, 'linkOptions'=>array()),
    array('label'=>'Search', 'icon'=>'icon-search', 'url'=>'#', 'linkOptions'=>array('class'=>'search-button')),
    array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
    array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
  ),
));
$this->endWidget();
?>



<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
  'model'=>$model,
)); ?>
</div><!-- search-form -->


<?php
$availability = array(
      array('value' => 0, 'text' => 'No'),
      array('value' => 1, 'text' => 'Yes'),
      
    );
$generic = array(
      array('value' => 0, 'text' => 'No'),
      array('value' => 1, 'text' => 'Yes'),
      
    );
$special = array(
      array('value' => 0, 'text' => 'No'),
      array('value' => 1, 'text' => 'Yes'),
      
    );
 $this->widget('bootstrap.widgets.TbGridView',array(
  'id'=>'drugs-grid',
  'dataProvider'=>$model->search(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
       // 'filter' => $model,

  'columns'=>array(
    'id',
    array( 
            'class' => 'editable.EditableColumn',
            'name' => 'drug',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('drugs/UpdateBooster'),
                'placement' => 'right',
            )
          ),
    array( 
                        'class' => 'editable.EditableColumn',
                        'name' => 'generic',

                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('drugs/updateBooster'),
                           'source'=>$generic,
                      
                          
              ),
          ),
    array(
                  'name'=>'cash',
                   'header'=>'Cash',
                   'type'=>'raw',
                   'value'=>'CHtml::link($data->cash,Yii::app()->createUrl("drugs/update", array("id"=>$data["id"])))',
                   
                        
           ),
    array( 
                        'class' => 'editable.EditableColumn',
                        'name' => 'availability',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('drugs/updateBooster'),
                           'source'=>$availability,
                      
                          
              ),
          ),
    array( 
                        'class' => 'editable.EditableColumn',
                        'name' => 'special',
                        'editable' => array(
                            'type'     => 'select',
                            'url'      => $this->createUrl('drugs/updateBooster'),
                           'source'=>$special,
                      
                          
              ),
          ),
       array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
      'template' => '{view} {delete}',
      'buttons' => array(
            'view' => array(
          'label'=> 'View',
          'options'=>array(
            'class'=>'btn btn-small view'
          )
        ),  
                             
        'delete' => array(
          'label'=> 'Delete',
          'options'=>array(
            'class'=>'btn btn-small delete'
          )
        )
      ),
            'htmlOptions'=>array('style'=>'width: 90px'),
           )
  ),
)); ?>

